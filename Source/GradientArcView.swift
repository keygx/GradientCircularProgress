//
//  GradientArcView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class GradientArcView : UIView {
    
    internal var prop: Property?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getGradientPointColor(ratio: CGFloat, startColor: UIColor, endColor: UIColor) -> UIColor {
        
        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var a1: CGFloat = 0.0
        
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a2: CGFloat = 0.0
        
        startColor.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        endColor.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        
        let r0 = (r2 - r1) * ratio + r1
        let g0 = (g2 - g1) * ratio + g1
        let b0 = (b2 - b1) * ratio + b1
        let a0 = (a2 - a1) * ratio + a1
        
        return UIColor(red: r0, green: g0, blue: b0, alpha: 1.0) // fixed alpha value
    }
    
    override func drawRect(rect: CGRect) {
        
        if let prop = prop {
            let circularRect = prop.getProgressRect()
            
            var currentAngle: CGFloat = 0.0
            
            // workaround
            var limit: CGFloat = 1.0 // 32bit
            if sizeof(limit.dynamicType) == 8 {
                limit = 1.01 // 64bit
            }
            
            for var i: CGFloat = 0.0; i <= limit; i += 0.01 {
                
                let arcPoint: CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
                let arcRadius: CGFloat = circularRect.width/2 + prop.arcLineWidth/2
                let arcStartAngle: CGFloat = -CGFloat(M_PI_2)
                let arcEndAngle: CGFloat = i * 2.0 * CGFloat(M_PI) - CGFloat(M_PI_2)
                
                if currentAngle == 0.0 {
                    currentAngle = arcStartAngle
                } else {
                    currentAngle = arcEndAngle - 0.1
                }
                
                let arc: UIBezierPath = UIBezierPath(arcCenter: arcPoint,
                    radius: arcRadius,
                    startAngle: currentAngle,
                    endAngle: arcEndAngle,
                    clockwise: true)
                
                let strokeColor: UIColor = getGradientPointColor(i, startColor: prop.startArcColor, endColor: prop.endArcColor)
                strokeColor.setStroke()
                
                arc.lineWidth = prop.arcLineWidth
                arc.lineCapStyle = prop.arcLineCapStyle
                arc.stroke()
            }
        }
    }
}
