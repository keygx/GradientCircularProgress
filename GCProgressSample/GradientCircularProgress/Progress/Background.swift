//
//  Background.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class Background {
    
    internal func blurEffectView(fromBlurStyle style: BackgroundStyles, frame: CGRect) -> UIVisualEffectView? {
        
        if getStyle(style) == nil {
            return nil
        }
        
        let effect = UIBlurEffect(style: getStyle(style)!)
        let blurView = UIVisualEffectView(effect: effect)
        blurView.frame = frame
        
        return blurView
    }
    
    private func getStyle(style: BackgroundStyles) -> UIBlurEffectStyle? {
        switch style {
            case .ExtraLight:
                return UIBlurEffectStyle.ExtraLight
            case .Light:
                return UIBlurEffectStyle.Light
            case .Dark:
                return UIBlurEffectStyle.Dark
            default:
                return nil
        }
    }
}
