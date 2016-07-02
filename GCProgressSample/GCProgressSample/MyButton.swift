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
        case normal
        case highlighted
        case selected
        case disabled
    }
    
    var status: ButtonStatus = .normal {
        didSet {
            switch status {
            case .disabled:
                isEnabled = false
            default:
                isEnabled = true
            }
            apply()
        }
    }
    
    private let defaultColor: UIColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    private let disabledColor: UIColor = UIColor.lightGray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        status = .normal
        
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
    }
    
    func apply() {
        switch status {
        case .disabled:
            setTitleColor(disabledColor, for: .disabled)
            layer.borderColor = disabledColor.cgColor
        default:
            setTitleColor(defaultColor, for: UIControlState())
            layer.borderColor = defaultColor.cgColor
        }
    }
}
