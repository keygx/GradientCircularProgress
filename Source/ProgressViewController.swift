//
//  ProgressViewController.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class ProgressViewController : UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        switch orientation {
        case .LandscapeLeft:
            fallthrough
        case .LandscapeRight:
            // LandscapeLeft | LandscapeRight
            return true
        default:
            // Unknown | Portrait | PortraitUpsideDown
            return false
        }
    }
    
    private func getViewRect() {
        
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        viewRect = window.frame
    }
    
    private func getBlurView() {
        
        guard let rect = viewRect, let prop = prop else {
            return
        }
        
        blurView = Background().blurEffectView(fromBlurStyle: prop.backgroundStyle, frame: rect)
        
        guard let blurView = blurView else {
            return
        }
        
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(blurView)
    }
    
    internal func arc(display: Bool, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let win = baseWindow, prop = prop else {
            return
        }
        
        win.userInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
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
        
        progressAtRatioView.center = self.view.center
        self.view.addSubview(progressAtRatioView)
    }
    
    internal func circle(message: String?, style: StyleProperty) {
        
        prop = Property(style: style)
        
        guard let win = baseWindow, prop = prop else {
            return
        }
        
        win.userInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
        getBlurView()
                
        circularProgressView = CircularProgressView(frame: CGRectMake(0, 0, prop.progressSize, prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(circularProgressView.frame)
        
        if message != nil {
            circularProgressView.showMessage(message!)
        }
        
        circularProgressView.center = self.view.center
        self.view.addSubview(circularProgressView)
    }
  
    internal func dismiss(t: Double) {
        
        let delay = t * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            guard let blurView = self.blurView, progressAtRatioView = self.progressAtRatioView, circularProgressView = self.circularProgressView else {
                return
            }
            
            UIView.animateWithDuration(
                0.3,
                animations: {
                    progressAtRatioView.alpha = 0.0
                    circularProgressView.alpha = 0.0
                },
                completion: { finished in
                    progressAtRatioView.removeFromSuperview()
                    circularProgressView.removeFromSuperview()
                    blurView.removeFromSuperview()
                }
            );
        })
    }
}
