//
//  GradientCircularProgress.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/07/29.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

internal var baseWindow: BaseWindow?

public class GradientCircularProgress {
    
    private var progressViewController: ProgressViewController?
    private var available: Bool = true
    
    public init() {}
    
    public func showAtRatio(display display: Bool = true, style: StyleProperty = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
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
    
    public func show(style style: StyleProperty = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
        getProgress(message: nil, style: style)
    }
    
    public func show(message message: String, style: StyleProperty = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
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
    
    public func updateRatio(ratio: CGFloat) {
        guard let vc = progressViewController else {
            return
        }
        
        vc.ratio = ratio
    }
    
    public func dismiss() -> Void {
        if available {
           return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4, completionHandler: nil)
    }
    
    public func dismiss(completionHandler: () -> Void) -> () {
        if available {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(t: Double, completionHandler: (() -> Void)?) -> Void {
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
                    self.available = true
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            );
        })
    }
}
