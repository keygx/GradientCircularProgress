//
//  BlueDarkStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

public class BlueDarkStyle : Style {
        
    public override init() {
        super.init()
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 260
        
        // Gradient Circular
        self.arcLineWidth = 4.0
        self.startArcColor = UIColor(red: 0.0/255.0, green: 122.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        self.endArcColor = UIColor.cyanColor()
        
        // Base Circular
        self.baseLineWidth = 5.0
        self.baseArcColor = UIColor(red:0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        
        // Percentage
        self.ratioLabelFont = UIFont(name: "Verdana-Bold", size: 16.0)!
        self.ratioLabelFontColor = UIColor.whiteColor()
        
        // Message
        self.messageLabelFont = UIFont.systemFontOfSize(16.0)
        self.messageLabelFontColor = UIColor.whiteColor()
        
        // Background
        self.backgroundStyle = .Dark
        /*** style properties **********************************************************************************/
    }
}
