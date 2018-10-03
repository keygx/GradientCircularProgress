//
//  ProgressView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2016/03/07.
//  Copyright (c) 2016年 keygx. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
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
        
        initialize(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    private func initialize(frame: CGRect) {
        viewRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        clipsToBounds = true
    }
    
    internal func arc(_ display: Bool, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
        
        getBlurView()
        
        progressAtRatioView = ProgressAtRatioView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let progressAtRatioView = progressAtRatioView else {
            return
        }
        
        progressAtRatioView.prop = prop
        progressAtRatioView.initialize(frame: progressAtRatioView.frame)
        
        if display {
            progressAtRatioView.showRatio()
        }
        
        progressAtRatioView.frame = CGRect(
            x: (frame.size.width - progressAtRatioView.frame.size.width) / 2,
            y: (frame.size.height - progressAtRatioView.frame.size.height) / 2,
            width: progressAtRatioView.frame.size.width,
            height: progressAtRatioView.frame.size.height)
        
        addSubview(progressAtRatioView)
    }
    
    internal func circle(_ message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let prop = prop else {
            return
        }
        
        isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false
                
        getBlurView()
        
        circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(frame: circularProgressView.frame)
        
        if let message = message {
            circularProgressView.showMessage(message)
        }
        
        circularProgressView.frame = CGRect(
            x: (frame.size.width - circularProgressView.frame.size.width) / 2,
            y: (frame.size.height - circularProgressView.frame.size.height) / 2,
            width: circularProgressView.frame.size.width,
            height: circularProgressView.frame.size.height)
        
        addSubview(circularProgressView)
    }
    
    internal func updateMessage(_ message: String) {
        
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
        
        backgroundColor = UIColor.clear
        addSubview(blurView)
    }
}
