//
//  GradientCircularProgress.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/07/29.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

internal var baseWindow: BaseWindow?

public class GradientCircularProgress {
    
    private var progressViewController: ProgressViewController?
    private var progressView: ProgressView?
    private var available: Bool = false
    
    public init() {}
}

// MARK: Common
extension GradientCircularProgress {
    
    public func updateMessage(message message: String) {
        if !available {
            return
        }
        
        // Use addSubView
        if let v = progressView {
            v.updateMessage(message)
        }
        
        // Use UIWindow
        if let vc = progressViewController {
            vc.updateMessage(message)
        }
    }
    
    public func updateRatio(ratio: CGFloat) {
        if !available {
            return
        }
        
        // Use addSubView
        if let v = progressView {
            v.ratio = ratio
        }
        
        // Use UIWindow
        if let vc = progressViewController {
            vc.ratio = ratio
        }
    }
}

// MARK: Use UIWindow
extension GradientCircularProgress {
    
    public func showAtRatio(display display: Bool = true, style: StyleProperty = Style()) {
        if available {
            return
        }
        available = true
        
        getProgressAtRatio(display, style: style)
    }
    
    private func getProgressAtRatio(display: Bool, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clearColor()
        vc.arc(display, style: style)
    }
    
    public func show(style style: StyleProperty = Style()) {
        if available {
            return
        }
        available = true
        
        getProgress(message: nil, style: style)
    }
    
    public func show(message message: String, style: StyleProperty = Style()) {
        if available {
            return
        }
        available = true
        
        getProgress(message: message, style: style)
    }
    
    private func getProgress(message message: String?, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clearColor()
        vc.circle(message, style: style)
    }
    
    public func dismiss() {
        if !available {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4, completionHandler: nil)
    }
    
    public func dismiss(completionHandler: () -> Void) -> () {
        if !available {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(t: Double, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            guard let win = baseWindow else {
                return
            }
            
            UIView.animateWithDuration(
                0.3,
                animations: {
                    win.alpha = 0
                },
                completion: { finished in
                    self.progressViewController = nil
                    win.hidden = true
                    win.rootViewController = nil
                    baseWindow = nil
                    self.available = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            );
        })
    }
}

// MARK: Use addSubView
extension GradientCircularProgress {
    
    public func showAtRatio(frame frame: CGRect, display: Bool = true, style: StyleProperty = Style()) -> UIView? {
        if available {
            return nil
        }
        available = true
        
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.arc(display, style: style)
        
        return v
    }
    
    public func show(frame frame: CGRect, style: StyleProperty = Style()) -> UIView? {
        if available {
            return nil
        }
        available = true
        
        return getProgress(frame: frame, message: nil, style: style)
    }
    
    public func show(frame frame: CGRect, message: String, style: StyleProperty = Style()) -> UIView? {
        if available {
            return nil
        }
        available = true
        
        return getProgress(frame: frame, message: message, style: style)
    }
    
    private func getProgress(frame frame: CGRect, message: String?, style: StyleProperty) -> UIView? {
        
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.circle(message, style: style)
        
        return v
    }
    
    public func dismiss(progress view: UIView) {
        if !available {
            return
        }
        
        cleanup(0.8, view: view, completionHandler: nil)
    }
    
    public func dismiss(progress view: UIView, completionHandler: () -> Void) -> () {
        if !available {
            return
        }
        
        cleanup(0.8, view: view) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(t: Double, view: UIView, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            UIView.animateWithDuration(
                0.3,
                animations: {
                    view.alpha = 0
                },
                completion: { finished in
                    view.removeFromSuperview()
                    self.available = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            );
        })
    }
}
