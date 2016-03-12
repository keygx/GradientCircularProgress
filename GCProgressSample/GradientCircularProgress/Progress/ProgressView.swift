//
//  ProgressView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2016/03/07.
//  Copyright (c) 2016年 keygx. All rights reserved.
//

import UIKit

class ProgressView : UIView {
    
    private var viewRect: CGRect?
    private var blurView: UIVisualEffectView?
    private var progressAtRatioView: ProgressAtRatioView?
    private var circularProgressView: CircularProgressView?
    internal var prop: Property?
    
    internal var ratio: CGFloat = 0.0 {
        didSet {
            progressAtRatioView?.ratio = ratio
            progressAtRatioView?.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize(frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(frame: CGRect) {
        viewRect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.clipsToBounds = true
    }
    
    internal func arc(display: Bool, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        self.userInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
        
        getBlurView()
        
        progressAtRatioView = ProgressAtRatioView(frame: CGRectMake(0, 0, prop.progressSize, prop.progressSize))
        
        guard let progressAtRatioView = progressAtRatioView else {
            return
        }
        
        progressAtRatioView.prop = prop
        progressAtRatioView.initialize(progressAtRatioView.frame)
        
        if display {
            progressAtRatioView.showRatio()
        }
        
        progressAtRatioView.frame = CGRectMake(
            (self.frame.size.width - progressAtRatioView.frame.size.width) / 2,
            (self.frame.size.height - progressAtRatioView.frame.size.height) / 2,
            progressAtRatioView.frame.size.width,
            progressAtRatioView.frame.size.height)
        
        self.addSubview(progressAtRatioView)
    }
    
    internal func circle(message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        self.userInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
                
        getBlurView()
        
        circularProgressView = CircularProgressView(frame: CGRectMake(0, 0, prop.progressSize, prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(circularProgressView.frame)
        
        if let message = message {
            circularProgressView.showMessage(message)
        }
        
        circularProgressView.frame = CGRectMake(
            (self.frame.size.width - circularProgressView.frame.size.width) / 2,
            (self.frame.size.height - circularProgressView.frame.size.height) / 2,
            circularProgressView.frame.size.width,
            circularProgressView.frame.size.height)
        
        self.addSubview(circularProgressView)
    }
    
    internal func updateMessage(message: String) {
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.message = message
    }
    
    private func getBlurView() {
        
        guard let rect = viewRect, let prop = prop else {
            return
        }
        
        blurView = Background().blurEffectView(fromBlurStyle: prop.backgroundStyle, frame: rect)
        
        guard let blurView = blurView else {
            return
        }
        
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(blurView)
    }
}
