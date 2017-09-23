//
//  ProgressViewController.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
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
        
        view.backgroundColor = UIColor.clear
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        let orientation:UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .landscapeLeft:
            fallthrough
        case .landscapeRight:
            // LandscapeLeft | LandscapeRight
            return true
        default:
            // Unknown | Portrait | PortraitUpsideDown
            return false
        }
    }
    
    private func getViewRect() {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
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
        
        view.backgroundColor = UIColor.clear
        view.addSubview(blurView)
    }
    
    internal func arc(display: Bool, style: StyleProperty, baseWindow: BaseWindow?) {
        
        prop = Property(style: style)
        
        guard let win = baseWindow, let prop = prop else {
            return
        }
        
        win.isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
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
        
        progressAtRatioView.center = view.center
        view.addSubview(progressAtRatioView)
    }
    
    internal func circle(message: String?, style: StyleProperty, baseWindow: BaseWindow?) {
        
        prop = Property(style: style)
        
        guard let win = baseWindow, let prop = prop else {
            return
        }
        
        win.isUserInteractionEnabled = !(prop.backgroundStyle.hashValue == 0) ? true : false // 0 == .None
        
        getViewRect()
        
        getBlurView()
                
        circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: prop.progressSize, height: prop.progressSize))
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.prop = prop
        circularProgressView.initialize(frame: circularProgressView.frame)
        
        if message != nil {
            circularProgressView.showMessage(message!)
        }
        
        circularProgressView.center = view.center
        view.addSubview(circularProgressView)
    }
    
    internal func updateMessage(message: String) {
        
        guard let circularProgressView = circularProgressView else {
            return
        }
        
        circularProgressView.message = message
    }
  
    internal func dismiss(_ t: Double) {
        
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            guard let blurView = self.blurView, let progressAtRatioView = self.progressAtRatioView, let circularProgressView = self.circularProgressView else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    progressAtRatioView.alpha = 0.0
                    circularProgressView.alpha = 0.0
                },
                completion: { finished in
                    progressAtRatioView.removeFromSuperview()
                    circularProgressView.removeFromSuperview()
                    blurView.removeFromSuperview()
                }
            )
        }
    }
}
