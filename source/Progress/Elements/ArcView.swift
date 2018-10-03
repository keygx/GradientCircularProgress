//
//  Arc.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class ArcView: UIView {
    
    var prop: Property?
    var ratio: CGFloat = 1.0
    var color: UIColor = UIColor.black
    var lineWidth: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, lineWidth: CGFloat) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
        self.lineWidth = lineWidth
    }
    
    override func draw(_ rect: CGRect) {
        
        drawArc(rect: rect)
    }
    
    private func drawArc(rect: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let circularRect: CGRect = prop.progressRect
        
        let arcPoint: CGPoint      = CGPoint(x: rect.width/2, y: rect.height/2)
        let arcRadius: CGFloat     = circularRect.width/2 + prop.arcLineWidth/2
        let arcStartAngle: CGFloat = -CGFloat.pi/2
        let arcEndAngle: CGFloat   = ratio * 2.0 * CGFloat.pi - CGFloat.pi/2
        
        let arc: UIBezierPath = UIBezierPath(arcCenter: arcPoint,
                                             radius: arcRadius,
                                             startAngle: arcStartAngle,
                                             endAngle: arcEndAngle,
                                             clockwise: true)
        
        color.setStroke()
        
        arc.lineWidth = lineWidth
        arc.lineCapStyle = prop.arcLineCapStyle
        arc.stroke()
    }
}
