//
//  BlueDarkStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/08/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct BlueDarkStyle: StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 260
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = ColorUtil.toUIColor(r: 0.0, g: 122.0, b: 255.0, a: 1.0)
    public var endArcColor: UIColor = UIColor.cyan
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 5.0
    public var baseArcColor: UIColor? = UIColor(red:0.0, green: 0.0, blue: 0.0, alpha: 0.2)
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.white
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.white
    
    // Background
    public var backgroundStyle: BackgroundStyles = .dark
    
    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.
    
    public init() {}
}
