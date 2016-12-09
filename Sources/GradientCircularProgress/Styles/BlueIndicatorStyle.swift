//
//  BlueIndicatorStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/08/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct BlueIndicatorStyle: StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 44
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = ColorUtil.toUIColor(r: 235.0, g: 245.0, b: 255.0, a: 1.0)
    public var endArcColor: UIColor = ColorUtil.toUIColor(r: 0.0, g: 122.0, b: 255.0, a: 1.0)
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 4.0
    public var baseArcColor: UIColor? = ColorUtil.toUIColor(r: 215.0, g: 215.0, b: 215.0, a: 0.4)
    
    // Ratio
    public var ratioLabelFont: UIFont? = nil
    public var ratioLabelFontColor: UIColor? = nil
    
    // Message
    public var messageLabelFont: UIFont? = nil
    public var messageLabelFontColor: UIColor? = nil
    
    // Background
    public var backgroundStyle: BackgroundStyles = .none
    
    // Dismiss
    public var dismissTimeInterval: Double? = nil // 'nil' for default setting.
    
    public init() {}
}
