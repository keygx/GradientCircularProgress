//
//  CircularProgressView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class CircularProgressView : UIView {
    
    var prop: Property?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initialize(frame: CGRect) {
        
        let rect: CGRect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        if let prop = prop {
            // Base Circular
            let circular: ArcView = ArcView(frame: rect, lineWidth: prop.baseLineWidth)
            circular.prop = prop
            circular.ratio = 1.0
            circular.color = prop.baseArcColor
            self.addSubview(circular)
            
            // Gradient Circular
            let gradient = GradientArcView(frame: rect)
            gradient.prop = prop
            self.addSubview(gradient)
            
            // Rotate Animation
            var animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            animation.duration = 0.8
            animation.repeatCount = HUGE
            animation.fromValue = NSNumber(float: 0.0)
            animation.toValue   = NSNumber(float: 2 * Float(M_PI))
            gradient.layer.addAnimation(animation, forKey: "rotate")
        }
    }
    
    internal func showMessage(message: String) {
                
        if let prop = prop {
            // Message
            let messageLabel: UILabel = UILabel(frame: self.frame)
            messageLabel.text = message
            messageLabel.font = prop.messageLabelFont
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.textColor = prop.messageLabelFontColor
            messageLabel.sizeToFit()
            messageLabel.center = self.center
            self.addSubview(messageLabel)
        }
    }
}
