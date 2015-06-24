//
//  Property.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class Property {
    
    let margin: CGFloat = 5.0
    let arcLineCapStyle: CGLineCap = kCGLineCapButt
    
    // Progress Size
    let progressSize: CGFloat
    
    // Gradient Circular
    let arcLineWidth: CGFloat
    let startArcColor: UIColor
    let endArcColor: UIColor
    
    // Base Circular
    let baseLineWidth: CGFloat
    let baseArcColor: UIColor
    
    // Ratio
    let ratioLabelFont: UIFont
    let ratioLabelFontColor: UIColor
    
    // Message
    let messageLabelFont: UIFont
    let messageLabelFontColor: UIColor
    
    // Background
    let backgroundStyle: BackgroundStyles
    
    init(style: Style) {
        
        let styles: Style = style
        
        self.progressSize          = styles.progressSize
        self.arcLineWidth          = styles.arcLineWidth
        self.startArcColor         = styles.startArcColor
        self.endArcColor           = styles.endArcColor
        self.baseLineWidth         = styles.baseLineWidth
        self.baseArcColor          = styles.baseArcColor
        self.ratioLabelFont        = styles.ratioLabelFont
        self.ratioLabelFontColor   = styles.ratioLabelFontColor
        self.messageLabelFont      = styles.messageLabelFont
        self.messageLabelFontColor = styles.messageLabelFontColor
        self.backgroundStyle       = styles.backgroundStyle
    }
    
    func getProgressRect() -> CGRect {
        let lineWidth: CGFloat = (arcLineWidth > baseLineWidth) ? arcLineWidth : baseLineWidth
        return CGRectMake(0, 0, progressSize - lineWidth * 2 - margin * 2, progressSize - lineWidth * 2 - margin * 2)
    }
}
