//
//  GradientArcView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class GradientArcView: UIView {
    
    internal var prop: Property?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
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
    
    override func draw(_ rect: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let circularRect: CGRect = prop.progressRect
        
        var currentAngle: CGFloat = 0.0
        
        for i in stride(from:CGFloat(0.0), through: CGFloat(1.0), by: CGFloat(0.005)) {
            
            let arcPoint: CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
            let arcRadius: CGFloat = circularRect.width/2 + prop.arcLineWidth/2
            let arcStartAngle: CGFloat = -CGFloat.pi/2
            let arcEndAngle: CGFloat = i * 2.0 * CGFloat.pi - CGFloat.pi/2
            
            if currentAngle == 0.0 {
                currentAngle = arcStartAngle
            } else {
                currentAngle = arcEndAngle - 0.05
            }
            
            let arc: UIBezierPath = UIBezierPath(arcCenter: arcPoint,
                                                 radius: arcRadius,
                                                 startAngle: currentAngle,
                                                 endAngle: arcEndAngle,
                                                 clockwise: true)
            
            let strokeColor: UIColor = getGradientPointColor(ratio: i, startColor: prop.startArcColor, endColor: prop.endArcColor)
            strokeColor.setStroke()
            
            arc.lineWidth = prop.arcLineWidth
            arc.lineCapStyle = prop.arcLineCapStyle
            arc.stroke()
        }
    }
}
