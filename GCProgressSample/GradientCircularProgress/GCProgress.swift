//
//  GCProgress.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

internal var baseWindow: BaseWindow?

public class GCProgress {
    
    /***
        GCProgress().showAtRatio(style: SubClass())
            --> Show gradient circular progress at ratio and percentage display
    
        GCProgress().showAtRatio(display: false, style: SubClass())
            --> Show gradient circular progress at ratio
    
        GCProgress().updateRatio(CGFloat(0.0 ~ 1.0))
            --> Update progress ratio
    
        GCProgress().show(style: SubClass())
            --> Show gradient circular progress
    
        GCProgress().show(message: "Loading...", style: SubClass())
            --> Show gradient circular progress with message display
    
        GCProgress().dismiss()
            --> Hide gradient circular progress
    ***/
    
    private var progressViewController: ProgressViewController?
    private var available: Bool = true
    
    public init() {}
    
    public func showAtRatio(display: Bool = true, style: Style = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
        getProgressAtRatio(display, style: style)
    }
    
    private func getProgressAtRatio(display: Bool, style: Style) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        if let win = baseWindow, vc = progressViewController {
            win.rootViewController = vc
            vc.arc(display, style: style)
        }
    }
    
    public func show(style: Style = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
        getProgress(message: nil, style: style)
    }
    
    public func show(#message: String, style: Style = Style()) -> Void {
        if !available {
            return
        }
        available = false
        
        getProgress(message: message, style: style)
    }
    
    private func getProgress(#message: String?, style: Style) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        if let win = baseWindow, vc = progressViewController {
            win.rootViewController = vc
            vc.circle(message, style: style)
        }
    }
    
    public func updateRatio(ratio: CGFloat) {
        if let vc = progressViewController {
            vc.ratio = ratio
        }
    }
    
    public func dismiss() -> Void {
        if available {
           return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.0)
    }
    
    private func cleanup(t: Double) -> Void {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            if let win = baseWindow {
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
                    }
                );
            }
        })
    }
}
