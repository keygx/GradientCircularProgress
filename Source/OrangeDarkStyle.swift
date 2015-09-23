//
//  OrangeDarkStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/08/31.
//  Copyright (c) 2015年 keygx. All rights reserved.
//


public struct OrangeDarkStyle : StyleProperty {
    // Progress Size
    public var progressSize: CGFloat = 200
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 18.0
    public var startArcColor: UIColor = UIColor.darkGrayColor()
    public var endArcColor: UIColor = UIColor.orangeColor()
    
    // Base Circular
    public var baseLineWidth: CGFloat = 19.0
    public var baseArcColor: UIColor = UIColor.darkGrayColor()
    
    // Ratio
    public var ratioLabelFont: UIFont = UIFont(name: "Verdana-Bold", size: 16.0)!
    public var ratioLabelFontColor = UIColor.whiteColor()
    
    // Message
    public var messageLabelFont: UIFont = UIFont.systemFontOfSize(16.0)
    public var messageLabelFontColor: UIColor = UIColor.whiteColor()
    
    // Background
    public var backgroundStyle: BackgroundStyles = .Dark
    
    public init() {}
}
