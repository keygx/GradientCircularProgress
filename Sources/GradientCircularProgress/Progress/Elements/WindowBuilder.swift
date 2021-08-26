//
//  WindowBuilder.swift
//  GradientCircularProgress
//
//  Created by keygx on 2019/09/24.
//  Copyright © 2019 keygx. All rights reserved.
//

import UIKit

class WindowBuilder {
    static func build() -> UIWindow? {
        var baseWindow: UIWindow?
        
        if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes
                                .filter { $0.activationState == .foregroundActive }.first
            if let windowScene = windowScene as? UIWindowScene {
                baseWindow = UIWindow(windowScene: windowScene)
            } else {
                baseWindow = UIWindow()
            }
        } else {
            baseWindow = UIWindow()
        }
        
        baseWindow?.bounds = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        baseWindow?.backgroundColor = UIColor.clear
        baseWindow?.windowLevel = UIWindow.Level.alert + 1
        baseWindow?.makeKeyAndVisible()
        
        return baseWindow
    }
}
