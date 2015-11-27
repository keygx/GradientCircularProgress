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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func getGradientPointColor(ratio: CGFloat, startColor: UIColor, endColor: UIColor) -> UIColor {
        
        let sColor = ColorUtil.toRGBA(color: startColor)
        let eColor = ColorUtil.toRGBA(color: endColor)
        
        let r = (eColor.r - sColor.r) * ratio + sColor.r
        let g = (eColor.g - sColor.g) * ratio + sColor.g
        let b = (eColor.b - sColor.b) * ratio + sColor.b
        let a = (eColor.a - sColor.a) * ratio + sColor.a
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    override func drawRect(rect: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let circularRect: CGRect = prop.progressRect
        
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
