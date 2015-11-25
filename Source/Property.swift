//
//  Property.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

public protocol StyleProperty {
    // Progress Size
    var progressSize: CGFloat { get set }
    
    // Gradient Circular
    var arcLineWidth: CGFloat { get set }
    var startArcColor: UIColor { get set }
    var endArcColor: UIColor { get set }
    
    // Base Circular
    var baseLineWidth: CGFloat? { get set }
    var baseArcColor: UIColor? { get set }
    
    // Ratio
    var ratioLabelFont: UIFont? { get set }
    var ratioLabelFontColor: UIColor? { get set }
    
    // Message
    var messageLabelFont: UIFont? { get set }
    var messageLabelFontColor: UIColor? { get set }
    
    // Background
    var backgroundStyle: BackgroundStyles { get set }
    
    // Initialize
    init()
}

public enum BackgroundStyles : Int {
    case None = 0
    case ExtraLight
    case Light
    case Dark
}


internal struct Property {
    let margin: CGFloat = 5.0
    let arcLineCapStyle: CGLineCap = CGLineCap.Butt
    
    // Progress Size
    var progressSize: CGFloat
    
    // Gradient Circular
    var arcLineWidth: CGFloat
    var startArcColor: UIColor
    var endArcColor: UIColor
    
    // Base Circular
    var baseLineWidth: CGFloat?
    var baseArcColor: UIColor?
    
    // Ratio
    let ratioLabelFont: UIFont?
    let ratioLabelFontColor: UIColor?
    
    // Message
    let messageLabelFont: UIFont?
    let messageLabelFontColor: UIColor?
    
    // Background
    let backgroundStyle: BackgroundStyles
    
    // Progress Rect
    var progressRect: CGRect {
        get {
            let lineWidth: CGFloat = (arcLineWidth > baseLineWidth) ? arcLineWidth : baseLineWidth!
            return CGRectMake(0, 0, progressSize - lineWidth * 2, progressSize - lineWidth * 2)
        }
    }
    
    init(style: StyleProperty) {
        
        let styles: StyleProperty = style
        
        self.progressSize          = styles.progressSize
        self.arcLineWidth          = styles.arcLineWidth
        self.startArcColor         = styles.startArcColor
        self.endArcColor           = styles.endArcColor
        self.baseLineWidth         = styles.baseLineWidth           ?? 0.0
        self.baseArcColor          = styles.baseArcColor            ?? UIColor.clearColor()
        self.ratioLabelFont        = styles.ratioLabelFont          ?? UIFont.systemFontOfSize(16.0)
        self.ratioLabelFontColor   = styles.ratioLabelFontColor     ?? UIColor.clearColor()
        self.messageLabelFont      = styles.messageLabelFont        ?? UIFont.systemFontOfSize(16.0)
        self.messageLabelFontColor = styles.messageLabelFontColor   ?? UIColor.clearColor()
        self.backgroundStyle       = styles.backgroundStyle
    }
}
