//
//  DefaultStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

public enum BackgroundStyles : Int {
    case None = 0
    case ExtraLight
    case Light
    case Dark
}

public class Style {
    
    // Progress Size
    public var progressSize: CGFloat
    
    // Gradient Circular
    public var arcLineWidth: CGFloat
    public var startArcColor: UIColor
    public var endArcColor: UIColor
    
    // Base Circular
    public var baseLineWidth: CGFloat
    public var baseArcColor: UIColor
    
    // Ratio
    public var ratioLabelFont: UIFont
    public var ratioLabelFontColor: UIColor
    
    // Message
    public var messageLabelFont: UIFont
    public var messageLabelFontColor: UIColor
    
    // Background
    public var backgroundStyle: BackgroundStyles
    
    public init() {
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 220
        
        // Gradient Circular
        self.arcLineWidth = 16.0
        self.startArcColor = UIColor(red:90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        self.endArcColor = UIColor(red:230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        // Base Circular
        self.baseLineWidth = 16.0
        self.baseArcColor = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.8)
        
        // Percentage
        self.ratioLabelFont = UIFont.systemFontOfSize(16.0)
        self.ratioLabelFontColor = UIColor.blackColor()
        
        // Message
        self.messageLabelFont = UIFont.systemFontOfSize(16.0)
        self.messageLabelFontColor = UIColor.blackColor()
        
        // Background
        self.backgroundStyle = .ExtraLight
        /*** style properties **********************************************************************************/
    }
}
