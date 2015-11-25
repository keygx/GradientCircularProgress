//
//  Arc.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class ArcView : UIView {
    
    var prop: Property?
    var ratio: CGFloat = 1.0
    var color: UIColor = UIColor.blackColor()
    var lineWidth: CGFloat = 0.0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect, lineWidth: CGFloat) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
        
        self.lineWidth = lineWidth
    }
    
    override func drawRect(rect: CGRect) {
        
        drawArc(rect)
    }
    
    private func drawArc(rect: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let circularRect: CGRect = prop.progressRect
        
        let arcPoint: CGPoint = CGPoint(x: rect.width/2, y: rect.height/2)
        let arcRadius: CGFloat = circularRect.width/2 + prop.arcLineWidth/2
        let arcStartAngle: CGFloat = -CGFloat(M_PI_2)
        let arcEndAngle: CGFloat = ratio * 2.0 * CGFloat(M_PI) - CGFloat(M_PI_2)
        
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
