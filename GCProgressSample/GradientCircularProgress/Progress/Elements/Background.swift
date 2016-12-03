//
//  Background.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


struct Background {
    
    internal func blurEffectView(fromBlurStyle style: BackgroundStyles, frame: CGRect) -> UIVisualEffectView? {
        
        var blurView: UIVisualEffectView?
        
        // return (blurEffectStyle: UIBlurEffectStyle?, isUserInteraction: Bool)
        let backgroundStyle = getStyle(style)
        
        if let blur = backgroundStyle.blurEffectStyle {
            // UIBlurEffectStyle (.extraLight, .light, .dark)
            let effect = UIBlurEffect(style: blur)
            blurView = UIVisualEffectView(effect: effect)
        
        } else {
            if !backgroundStyle.isUserInteraction {
                // .transparent
                blurView = UIVisualEffectView(effect: nil)
            }
        }
        
        blurView?.frame = frame
        return blurView
    }
    
    private func getStyle(_ style: BackgroundStyles) -> (blurEffectStyle: UIBlurEffectStyle?, isUserInteraction: Bool) {
        switch style {
        case .extraLight:
            return (.extraLight, false)
        case .light:
            return (.light, false)
        case .dark:
            return (.dark, false)
        case .transparent:
            return (nil, false)
        default:
            // .none
            return (nil, true)
        }
    }
}
