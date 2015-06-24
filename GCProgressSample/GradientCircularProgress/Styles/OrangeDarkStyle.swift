//
//  OrangeDarkStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

public class OrangeDarkStyle : Style {
        
    public override init() {
        super.init()
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 200
        
        // Gradient Circular
        self.arcLineWidth = 18.0
        self.startArcColor = UIColor.darkGrayColor()
        self.endArcColor = UIColor.orangeColor()
        
        // Base Circular
        self.baseLineWidth = 19.0
        self.baseArcColor = UIColor.darkGrayColor()
        
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
