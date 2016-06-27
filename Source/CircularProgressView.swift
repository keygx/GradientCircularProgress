//
//  CircularProgressView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class CircularProgressView : UIView {
    
    var prop: Property?
    var messageLabel = UILabel()
    var centerPoint: CGPoint?
    
    var message: String? {
        willSet {
            messageLabel.frame = self.frame
            messageLabel.text = newValue
            
            guard let message = messageLabel.text else {
                return
            }
            
            // Attribute
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.2;
            paragraphStyle.alignment = NSTextAlignment.Center
            let attr = [NSParagraphStyleAttributeName: paragraphStyle]
            let attributedString = NSMutableAttributedString(string: message, attributes: attr)
            
            messageLabel.attributedText = attributedString
            
            messageLabel.sizeToFit()
            
            if centerPoint == nil {
                centerPoint = self.center
            }
            
            if let center = centerPoint {
                messageLabel.center = center
            }
        }
    }
    
    var gradientLayer = CALayer()
    
    private struct Animation {
        var rotationZ: CABasicAnimation {
            get {
                let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
                animation.duration = 0.8
                animation.repeatCount = HUGE
                animation.fromValue = NSNumber(float: 0.0)
                animation.toValue = NSNumber(float: 2 * Float(M_PI))
                
                return animation
            }
        }
        
        init() {}
        
        func start(layer: CALayer) {
            layer.addAnimation(rotationZ, forKey: "rotate")
        }
        
        func stop(layer: CALayer) {
            layer.removeAllAnimations()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(viewDidEnterBackground(_:)),
                                                         name: UIApplicationDidEnterBackgroundNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(viewWillEnterForeground(_:)),
                                                         name: UIApplicationWillEnterForegroundNotification,
                                                         object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @objc private func viewDidEnterBackground(notification: NSNotification?) {
        Animation().stop(gradientLayer)
    }
    
    @objc private func viewWillEnterForeground(notification: NSNotification?) {
        Animation().start(gradientLayer)
    }
    
    internal func initialize(frame: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let rect: CGRect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        // Base Circular
        if let baseLineWidth = prop.baseLineWidth, let baseArcColor = prop.baseArcColor {
            let circular: ArcView = ArcView(frame: rect, lineWidth: baseLineWidth)
            circular.color = baseArcColor
            circular.prop = prop
            self.addSubview(circular)
        }
        
        // Gradient Circular
        if ColorUtil.toRGBA(color: prop.startArcColor).a < 1.0 || ColorUtil.toRGBA(color: prop.endArcColor).a < 1.0 {
            // Clear Color
            let gradient: UIView = GradientArcWithClearColorView().draw(rect, prop: prop)
            self.addSubview(gradient)
            
            gradientLayer = gradient.layer
            Animation().start(gradientLayer)
            
        } else {
            // Opaque Color
            let gradient: GradientArcView = GradientArcView(frame: rect)
            gradient.prop = prop
            self.addSubview(gradient)
            
            gradientLayer = gradient.layer
            Animation().start(gradientLayer)
        }
    }
    
    internal func showMessage(message: String) {
        
        guard let prop = prop else {
            return
        }
        
        // Message
        messageLabel.font = prop.messageLabelFont
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.textColor = prop.messageLabelFontColor
        messageLabel.numberOfLines = 0

        self.addSubview(messageLabel)
        
        self.message = message
    }
}
