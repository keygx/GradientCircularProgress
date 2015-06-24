//
//  IndicatorStyle.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

public class IndicatorStyle : Style {
    
    public override init() {
        super.init()
        /*** style properties **********************************************************************************/
        // Progress Size
        self.progressSize = 54
        
        // Gradient Circular
        self.arcLineWidth = 4.0
        self.startArcColor = UIColor(red:90.0/255.0, green: 90.0/255.0, blue: 90.0/255.0, alpha: 1.0)
        self.endArcColor = UIColor(red:230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        
        // Base Circular
        self.baseLineWidth = 4.0
        self.baseArcColor = UIColor(red: 215.0/255.0, green: 215.0/255.0, blue: 215.0/255.0, alpha: 0.4)
        
        // Background
        self.backgroundStyle = .None
        /*** style properties **********************************************************************************/
    }
}
