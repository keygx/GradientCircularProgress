//
//  AlertHelperKit.swift
//
//  Created by keygx on 2015/07/21.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

public enum ActionSheetPopoverStyle: Int {
    case Normal = 0
    case BarButton
}

public struct Parameters {
    var title: String?
    var message: String?
    var cancelButton: String?
    var otherButtons: [String]?
    var destructiveButtons: [String]?
    var disabledButtons: [String]?
    var inputFields: [InputField]?
    var sender: AnyObject?
    var arrowDirection: UIPopoverArrowDirection?
    var popoverStyle: ActionSheetPopoverStyle = .Normal
    
    public init(
        title: String? = nil,
        message: String? = nil,
        cancelButton: String? = nil,
        otherButtons: [String]? = nil,
        destructiveButtons: [String]? = nil,
        disabledButtons: [String]? = nil,
        inputFields: [InputField]? = nil,
        sender: AnyObject? = nil,
        arrowDirection: UIPopoverArrowDirection? = nil,
        popoverStyle: ActionSheetPopoverStyle = .Normal
    ) {
        self.title = title
        self.message = message
        self.cancelButton = cancelButton
        self.otherButtons = otherButtons
        self.destructiveButtons = destructiveButtons
        self.disabledButtons = disabledButtons
        self.inputFields = inputFields
        self.sender = sender
        self.arrowDirection = arrowDirection
        self.popoverStyle = popoverStyle
    }
}

public struct InputField {
    var placeholder: String
    var secure: Bool?
    
    public init(placeholder: String, secure: Bool?) {
        self.placeholder = placeholder
        self.secure = secure
    }
}

public class AlertHelperKit {
    
    public var animated: Bool = true
    public var completionHandler: (() -> Void)?
    public var textFields: [AnyObject]?
    
    public init() {
        initialize()
    }
    
    private func initialize() {
        animated = true
        completionHandler = nil
        textFields = nil
    }
    
    // Alert
    public func showAlert(parent: UIViewController, title: String?, message: String?, button: String) {
            
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // cancel
        let cancelAction = UIAlertAction(title: button, style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        show(parent, ac: alertController)
    }
    
    // Alert with Callback Handler
    public func showAlertWithHandler(parent: UIViewController, parameters: Parameters, handler: (Int) -> ()) {
        
        let alertController: UIAlertController = buildAlertController(.Alert, params: parameters) { buttonIndex in
            handler(buttonIndex)
        }
        
        buttonDisabled(alertController, params: parameters)
        
        show(parent, ac: alertController)
    }
    
    // ActionSheet
    public func showActionSheet(parent: UIViewController, parameters: Parameters, handler: (Int) -> ()) {
        
        let alertController: UIAlertController = buildAlertController(.ActionSheet, params: parameters) { buttonIndex in
            handler(buttonIndex)
        }
        
        buttonDisabled(alertController, params: parameters)
        
        if let popover = alertController.popoverPresentationController, let sender: AnyObject = parameters.sender, let arrowDirection = parameters.arrowDirection {
            popover.sourceView = parent.view
            
            switch parameters.popoverStyle {
            case .BarButton:
                popover.barButtonItem = sender as? UIBarButtonItem
            default:
                popover.sourceRect = sender.frame
            }
            
            popover.permittedArrowDirections = arrowDirection
        }
        
        show(parent, ac: alertController)
    }
    
    // Build AlertController
    private func buildAlertController(style: UIAlertControllerStyle, params: Parameters, handler: (Int) -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: params.title, message: params.message, preferredStyle: style)
        let destructivOffset = 1
        var othersOffset = destructivOffset
        
        // cancel
        if let cancel = params.cancelButton {
            let cancelAction = UIAlertAction(title: cancel, style: .Cancel) {
                action in handler(0)
            }
            alertController.addAction(cancelAction)
        }
        
        // destructive
        if let destructive = params.destructiveButtons {
            for i in 0..<destructive.count {
                let destructiveAction = UIAlertAction(title: destructive[i], style: .Destructive) {
                    action in handler(i + destructivOffset)
                }
                alertController.addAction(destructiveAction)
                
                ++othersOffset
            }
        }
        
        // others
        if let others = params.otherButtons {
            for i in 0..<others.count {
                let otherAction = UIAlertAction(title: others[i], style: .Default) {
                    action in handler(i + othersOffset)
                }
                alertController.addAction(otherAction)
            }
        }
        
        // textFields
        if style != .ActionSheet {
            if let inputFields = params.inputFields {
                for i in 0..<inputFields.count {
                    alertController.addTextFieldWithConfigurationHandler({ textField in
                        // placeholder
                        textField.placeholder = inputFields[i].placeholder
                        // secure
                        if let secure = inputFields[i].secure {
                            textField.secureTextEntry = secure
                        }
                    })
                }
            }
        }
        
        return alertController
    }
    
    // Button Disabled
    private func buttonDisabled(alertController: UIAlertController, params: Parameters) {
        guard let buttons = params.disabledButtons else {
            return
        }
        
        for alertAction in alertController.actions {
            let action: UIAlertAction = alertAction
            for title in buttons {
                if action.title == title {
                    action.enabled = false
                }
            }
        }
    }
    
    // Appear Alert
    private func show(vc: UIViewController, ac: UIAlertController) {
        self.textFields = ac.textFields
        vc.presentViewController(ac, animated: animated, completion: completionHandler)
    }
    
}
