//
//  OrangeClearStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/11/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct OrangeClearStyle : StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 80
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 6.0
    public var startArcColor: UIColor = UIColor.clearColor()
    public var endArcColor: UIColor = UIColor.orangeColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat? = nil
    public var baseArcColor: UIColor? = nil
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont.systemFontOfSize(13.0)
    public var ratioLabelFontColor: UIColor? = UIColor.blackColor()
    
    // Message
    public var messageLabelFont: UIFont? = nil
    public var messageLabelFontColor: UIColor? = nil
    
    // Background
    public var backgroundStyle: BackgroundStyles = .None
    
    public init() {}
}
