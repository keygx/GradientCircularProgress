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
    
    // Dismiss
    var dismissTimeInterval: Double? { get set }
    
    // Initialize
    init()
}

public enum BackgroundStyles: Int {
    case none = 0
    case extraLight
    case light
    case dark
    case transparent
}


internal struct Property {
    let margin: CGFloat = 5.0
    let arcLineCapStyle: CGLineCap = CGLineCap.butt
    
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
    
    // Dismiss
    let dismissTimeInterval: Double?
    
    // Progress Rect
    var progressRect: CGRect {
        let lineWidth: CGFloat = (arcLineWidth > baseLineWidth!) ? arcLineWidth : baseLineWidth!
        return CGRect(x: 0, y: 0, width: progressSize - lineWidth * 2, height: progressSize - lineWidth * 2)
    }
    
    init(style: StyleProperty) {
        
        let styles: StyleProperty = style
        
        progressSize          = styles.progressSize
        arcLineWidth          = styles.arcLineWidth
        startArcColor         = styles.startArcColor
        endArcColor           = styles.endArcColor
        baseLineWidth         = styles.baseLineWidth         ?? 0.0
        baseArcColor          = styles.baseArcColor          ?? UIColor.clear
        ratioLabelFont        = styles.ratioLabelFont        ?? UIFont.systemFont(ofSize: 16.0)
        ratioLabelFontColor   = styles.ratioLabelFontColor   ?? UIColor.clear
        messageLabelFont      = styles.messageLabelFont      ?? UIFont.systemFont(ofSize: 16.0)
        messageLabelFontColor = styles.messageLabelFontColor ?? UIColor.clear
        backgroundStyle       = styles.backgroundStyle
        dismissTimeInterval   = styles.dismissTimeInterval    ?? 0.8
    }
}
