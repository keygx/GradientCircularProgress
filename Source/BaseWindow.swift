//
//  BaseWindow.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class BaseWindow : UIWindow {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let orientation:UIInterfaceOrientation = UIApplication.sharedApplication().statusBarOrientation
        
        switch orientation {
            case .LandscapeLeft:
                fallthrough
            case .LandscapeRight:
                // LandscapeLeft | LandscapeRight
                self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width)
            default:
                // Unknown | Portrait | PortraitUpsideDown
                self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        }
        
        self.backgroundColor = UIColor.clearColor()
        self.windowLevel = UIWindowLevelAlert + 1
        
        self.makeKeyWindow()
        
        self.makeKeyAndVisible()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
