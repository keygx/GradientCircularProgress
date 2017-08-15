//
//  GradientCircularProgress.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/07/29.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

public class GradientCircularProgress {
    
    private var baseWindow: BaseWindow?
    private var progressViewController: ProgressViewController?
    private var progressView: ProgressView?
    private var property: Property?
    
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
            vc.updateMessage(message: message)
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
        property = Property(style: style)
        
        getProgressAtRatio(display: display, style: style)
    }
    
    private func getProgressAtRatio(display: Bool, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, let vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clear
        vc.arc(display: display, style: style, baseWindow: baseWindow)
    }
    
    public func show(style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        property = Property(style: style)
        
        getProgress(message: nil, style: style)
    }
    
    public func show(message: String, style: StyleProperty = Style()) {
        if isAvailable {
            return
        }
        isAvailable = true
        property = Property(style: style)
        
        getProgress(message: message, style: style)
    }
    
    private func getProgress(message: String?, style: StyleProperty) {
        baseWindow = BaseWindow()
        progressViewController = ProgressViewController()
        
        guard let win = baseWindow, let vc = progressViewController else {
            return
        }
        
        win.rootViewController = vc
        win.backgroundColor = UIColor.clear
        vc.circle(message: message, style: style, baseWindow: baseWindow)
    }
    
    public func dismiss() {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(prop.dismissTimeInterval!)
        }
        
        cleanup(prop.dismissTimeInterval!, completionHandler: nil)
        
    }
    
    public func dismiss(_ completionHandler: @escaping () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        if let vc = progressViewController {
            vc.dismiss(prop.dismissTimeInterval!)
        }
        
        cleanup(prop.dismissTimeInterval!) {
            completionHandler()
        }
    }
    
    private func cleanup(_ t: Double, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            guard let win = self?.baseWindow else {
                return
            }
            
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    win.alpha = 0
                },
                completion: { finished in
                    self?.progressViewController = nil
                    win.isHidden = true
                    win.rootViewController = nil
                    self?.baseWindow = nil
                    self?.property = nil
                    self?.isAvailable = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            )
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
        property = Property(style: style)
        
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
        property = Property(style: style)
        
        return getProgress(frame: frame, message: nil, style: style)
    }
    
    public func show(frame: CGRect, message: String, style: StyleProperty = Style()) -> UIView? {
        if isAvailable {
            return nil
        }
        isAvailable = true
        property = Property(style: style)
        
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
        
        guard let prop = property else {
            return
        }
        
        cleanup(prop.dismissTimeInterval!, view: view, completionHandler: nil)
    }
    
    public func dismiss(progress view: UIView, completionHandler: @escaping () -> Void) -> () {
        if !isAvailable {
            return
        }
        
        guard let prop = property else {
            return
        }
        
        cleanup(prop.dismissTimeInterval!, view: view) {
            completionHandler()
        }
    }
    
    private func cleanup(_ t: Double, view: UIView, completionHandler: (() -> Void)?) {
        let delay = t * Double(NSEC_PER_SEC)
        let time  = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            UIView.animate(
                withDuration: 0.3,
                animations: {
                    view.alpha = 0
                },
                completion: { [weak self] finished in
                    view.removeFromSuperview()
                    self?.property = nil
                    self?.isAvailable = false
                    guard let completionHandler = completionHandler else {
                        return
                    }
                    completionHandler()
                }
            )
        }
    }
}
