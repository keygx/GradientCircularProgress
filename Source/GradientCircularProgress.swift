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
    
    public var isAvailable: Bool = false
    
    public init() {}
}

// MARK: Common
extension GradientCircularProgress {
    
    public func updateMessage(message: String) {
        if !isAvailable {
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
    
    public func updateRatio(_ ratio: CGFloat) {
        if !isAvailable {
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
    
    public func showAtRatio(display: Bool = true, style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        
        getProgressAtRatio(display, style: style)
    }
    
    private func getProgressAtRatio(_ display: Bool, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, let vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clear()
        vc.arc(display, style: style)
    }
    
    public func show(style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        
        getProgress(message: nil, style: style)
    }
    
    public func show(message: String, style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        
        getProgress(message: message, style: style)
    }
    
    private func getProgress(message: String?, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, let vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clear()
        vc.circle(message, style: style)
    }
    
    public func dismiss() {
        if !isAvailable {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4, completionHandler: nil)
    }
    
    public func dismiss(_ completionHandler: () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(0.6)
        }
        
        cleanup(1.4) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(_ t: Double, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.after(when: time) {
            guard let win = baseWindow else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    win.alpha = 0
                },
                completion: { [unowned self] finished in
                    self.progressViewController = nil
                    win.isHidden = true
                    win.rootViewController = nil
                    baseWindow = nil
                    self.isAvailable = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            );
        }
    }
}

// MARK: Use addSubView
extension GradientCircularProgress {
    
    public func showAtRatio(frame: CGRect, display: Bool = true, style: StyleProperty = Style()) -> UIView? {
        if isAvailable {
            return nil
        }
        isAvailable = true
        
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.arc(display, style: style)
        
        return v
    }
    
    public func show(frame: CGRect, style: StyleProperty = Style()) -> UIView? {
        if isAvailable {
            return nil
        }
        isAvailable = true
        
        return getProgress(frame: frame, message: nil, style: style)
    }
    
    public func show(frame: CGRect, message: String, style: StyleProperty = Style()) -> UIView? {
        if isAvailable {
            return nil
        }
        isAvailable = true
        
        return getProgress(frame: frame, message: message, style: style)
    }
    
    private func getProgress(frame: CGRect, message: String?, style: StyleProperty) -> UIView? {
        
        progressView = ProgressView(frame: frame)
        
        guard let v = progressView else {
            return nil
        }
        
        v.circle(message, style: style)
        
        return v
    }
    
    public func dismiss(progress view: UIView) {
        if !isAvailable {
            return
        }
        
        cleanup(0.8, view: view, completionHandler: nil)
    }
    
    public func dismiss(progress view: UIView, completionHandler: () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        cleanup(0.8, view: view) { Void in
            completionHandler()
        }
    }
    
    private func cleanup(_ t: Double, view: UIView, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.after(when: time) {
            
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    view.alpha = 0
                },
                completion: { [unowned self] finished in
                    view.removeFromSuperview()
                    self.isAvailable = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            );
        }
    }
}
