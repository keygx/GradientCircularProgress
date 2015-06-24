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
        
        if let rect = viewRect, let prop = prop {
            
            blurView = Background().blurEffectView(fromBlurStyle: prop.backgroundStyle, frame: rect)
            
            if let blurView = blurView {
                self.view.backgroundColor = UIColor.clearColor()
                self.view.addSubview(blurView)
            }
        }
    }
    
    internal func arc(display: Bool, style: Style) {
        
        prop = Property(style: style)
        
        baseWindow!.userInteractionEnabled = !(prop?.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
        getBlurView()
        
        if let prop = prop {
        
            progressAtRatioView = ProgressAtRatioView(frame: CGRectMake(0, 0, prop.progressSize, prop.progressSize))
            
            if let progressAtRatioView = progressAtRatioView {
                progressAtRatioView.prop = prop
                progressAtRatioView.initialize(progressAtRatioView.frame)
                
                if display {
                    progressAtRatioView.showRatio()
                }
                
                progressAtRatioView.center = self.view.center
                self.view.addSubview(progressAtRatioView)
            }
        }
    }
    
    internal func circle(message: String?, style: Style) {
        
        prop = Property(style: style)
        
        baseWindow!.userInteractionEnabled = !(prop?.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
        getBlurView()
                
        if let prop = prop {
            circularProgressView = CircularProgressView(frame: CGRectMake(0, 0, prop.progressSize, prop.progressSize))
            
            if let circularProgressView = circularProgressView {
                circularProgressView.prop = prop
                circularProgressView.initialize(circularProgressView.frame)
                
                if message != nil {
                    circularProgressView.showMessage(message!)
                }
                
                circularProgressView.center = self.view.center
                self.view.addSubview(circularProgressView)
            }
        }
    }
  
    internal func dismiss(t: Double) {
        
        let delay = t * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            if let blurView = self.blurView, let progressAtRatioView = self.progressAtRatioView, let circularProgressView = self.circularProgressView {
                
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
            }
        })
    }
}
