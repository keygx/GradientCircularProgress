//
//  AlertHelperKit.swift
//
//  Created by keygx on 2015/07/21.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

public enum ActionSheetPopoverStyle: Int {
    case normal = 0
    case barButton
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
    var popoverStyle: ActionSheetPopoverStyle = .normal
    
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
        popoverStyle: ActionSheetPopoverStyle = .normal
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
    public func showAlert(_ parent: UIViewController, title: String?, message: String?, button: String) {
            
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // cancel
        let cancelAction = UIAlertAction(title: button, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        show(parent, ac: alertController)
    }
    
    // Alert with Callback Handler
    public func showAlertWithHandler(_ parent: UIViewController, parameters: Parameters, handler: (Int) -> ()) {
        
        let alertController: UIAlertController = buildAlertController(.alert, params: parameters) { buttonIndex in
            handler(buttonIndex)
        }
        
        buttonDisabled(alertController, params: parameters)
        
        show(parent, ac: alertController)
    }
    
    // ActionSheet
    public func showActionSheet(_ parent: UIViewController, parameters: Parameters, handler: (Int) -> ()) {
        
        let alertController: UIAlertController = buildAlertController(.actionSheet, params: parameters) { buttonIndex in
            handler(buttonIndex)
        }
        
        buttonDisabled(alertController, params: parameters)
        
        if let popover = alertController.popoverPresentationController, let sender: AnyObject = parameters.sender, let arrowDirection = parameters.arrowDirection {
            popover.sourceView = parent.view
            
            switch parameters.popoverStyle {
            case .barButton:
                popover.barButtonItem = sender as? UIBarButtonItem
            default:
                popover.sourceRect = sender.frame
            }
            
            popover.permittedArrowDirections = arrowDirection
        }
        
        show(parent, ac: alertController)
    }
    
    // Build AlertController
    private func buildAlertController(_ style: UIAlertControllerStyle, params: Parameters, handler: (Int) -> ()) -> UIAlertController {
        
        let alertController = UIAlertController(title: params.title, message: params.message, preferredStyle: style)
        let destructivOffset = 1
        var othersOffset = destructivOffset
        
        // cancel
        if let cancel = params.cancelButton {
            let cancelAction = UIAlertAction(title: cancel, style: .cancel) {
                action in handler(0)
            }
            alertController.addAction(cancelAction)
        }
        
        // destructive
        if let destructive = params.destructiveButtons {
            for i in 0..<destructive.count {
                let destructiveAction = UIAlertAction(title: destructive[i], style: .destructive) {
                    action in handler(i + destructivOffset)
                }
                alertController.addAction(destructiveAction)
                
                othersOffset += 1
            }
        }
        
        // others
        if let others = params.otherButtons {
            for i in 0..<others.count {
                let otherAction = UIAlertAction(title: others[i], style: .default) {
                    action in handler(i + othersOffset)
                }
                alertController.addAction(otherAction)
            }
        }
        
        // textFields
        if style != .actionSheet {
            if let inputFields = params.inputFields {
                for i in 0..<inputFields.count {
                    alertController.addTextField(configurationHandler: { textField in
                        // placeholder
                        textField.placeholder = inputFields[i].placeholder
                        // secure
                        if let secure = inputFields[i].secure {
                            textField.isSecureTextEntry = secure
                        }
                    })
                }
            }
        }
        
        return alertController
    }
    
    // Button Disabled
    private func buttonDisabled(_ alertController: UIAlertController, params: Parameters) {
        guard let buttons = params.disabledButtons else {
            return
        }
        
        for alertAction in alertController.actions {
            let action: UIAlertAction = alertAction
            for title in buttons {
                if action.title == title {
                    action.isEnabled = false
                }
            }
        }
    }
    
    // Appear Alert
    private func show(_ vc: UIViewController, ac: UIAlertController) {
        self.textFields = ac.textFields
        vc.present(ac, animated: animated, completion: completionHandler)
    }
    
}
