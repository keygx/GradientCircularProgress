//
//  DefaultStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/08/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct Style: StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 220
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 16.0
    public var startArcColor: UIColor = ColorUtil.toUIColor(r: 230.0, g: 230.0, b: 230.0, a: 0.6)
    public var endArcColor: UIColor = ColorUtil.toUIColor(r: 90.0, g: 90.0, b: 90.0, a: 1.0)
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 16.0
    public var baseArcColor: UIColor? = UIColor(red:1.0, green: 1.0, blue: 1.0, alpha: 0.8)
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFont(ofSize: 18.0)
    public var ratioLabelFontColor: UIColor? = UIColor.black
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 18.0)
    public var messageLabelFontColor: UIColor? = UIColor.black
    
    // Background
    public var backgroundStyle: BackgroundStyles = .extraLight
    
    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.
    
    public init() {}
}
