//
//  MyButton.swift
//  GCProgressSample
//
//  Created by keygx on 2016/03/12.
//  Copyright © 2016年 keygx. All rights reserved.
//

import UIKit



class MyButton: UIButton {
    
    enum ButtonStatus {
        case Normal
        case Highlighted
        case Selected
        case Disabled
    }
    
    var status: ButtonStatus = .Normal {
        didSet {
            switch status {
            case .Disabled:
                enabled = false
            default:
                enabled = true
            }
            apply()
        }
    }
    
    private let defaultColor: UIColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    private let disabledColor: UIColor = UIColor.lightGrayColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        status = .Normal
        
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
    }
    
    func apply() {
        switch status {
        case .Disabled:
            setTitleColor(disabledColor, forState: .Disabled)
            layer.borderColor = disabledColor.CGColor
        default:
            setTitleColor(defaultColor, forState: .Normal)
            layer.borderColor = defaultColor.CGColor
        }
    }
}
