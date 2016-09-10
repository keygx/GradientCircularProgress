//
//  Background.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


struct Background {
    
    internal func blurEffectView(fromBlurStyle style: BackgroundStyles, frame: CGRect) -> UIVisualEffectView? {
        
        guard let backgroundStyle = getStyle(style) else {
            return nil
        }
        
        let effect = UIBlurEffect(style: backgroundStyle)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = frame
        
        return blurView
    }
    
    private func getStyle(_ style: BackgroundStyles) -> UIBlurEffectStyle? {
        switch style {
        case .extraLight:
            return .extraLight
        case .light:
            return .light
        case .dark:
            return .dark
        default:
            return nil
        }
    }
}
