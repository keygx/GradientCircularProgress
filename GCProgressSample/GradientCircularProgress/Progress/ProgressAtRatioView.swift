//
//  ProgressAtRatioView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/06/24.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class ProgressAtRatioView : UIView {
    
    private var mask: ArcView?
    internal var prop: Property?
    internal var ratioLabel: UILabel = UILabel()
    
    internal var ratio: CGFloat = 0.0 {
        didSet {
            ratioLabel.text = String(format:"%.0f", ratio * 100) + "%"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initialize(frame: CGRect) {
        
        guard let prop = prop else {
            return
        }
        
        let rect: CGRect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        // Base Circular
        if let baseLineWidth = prop.baseLineWidth, let baseArcColor = prop.baseArcColor {
            let circular: ArcView = ArcView(frame: rect, lineWidth: baseLineWidth)
            circular.prop = prop
            circular.ratio = 1.0
            circular.color = baseArcColor
            circular.lineWidth = baseLineWidth
            self.addSubview(circular)
        }
        
        // Gradient Circular
        if ColorUtil.toRGBA(color: prop.startArcColor).a < 1.0 || ColorUtil.toRGBA(color: prop.endArcColor).a < 1.0 {
            // Clear Color
            let gradient: UIView = GradientArcWithClearColorView().draw(rect, prop: prop)
            self.addSubview(gradient)
            
            masking(rect: rect, prop: prop, gradient: gradient)
            
        } else {
            // Opaque Color
            let gradient: GradientArcView = GradientArcView(frame: rect)
            gradient.prop = prop
            self.addSubview(gradient)
            
            masking(rect: rect, prop: prop, gradient: gradient)
        }
    }
    
    private func masking(rect rect: CGRect, prop: Property, gradient: UIView) {
        // Mask
        mask = ArcView(frame: rect, lineWidth: prop.arcLineWidth)
        
        guard let mask = mask else {
            return
        }
        
        mask.prop = prop
        let maskView = mask
        maskView.frame = mask.frame
        gradient.layer.mask = maskView.layer
    }
    
    override func drawRect(rect: CGRect) {
        
        guard let mask = mask else {
            return
        }
        
        if ratio > 1.0 {
            mask.ratio = 1.0
        } else {
            mask.ratio = ratio
        }
        mask.setNeedsDisplay()
    }
    
    func showRatio() {
        
        guard let prop = prop else {
            return
        }
        
        // Progress Ratio
        ratioLabel.text = "          "
        ratioLabel.font = prop.ratioLabelFont
        ratioLabel.textAlignment = NSTextAlignment.Right
        ratioLabel.textColor = prop.ratioLabelFontColor
        ratioLabel.sizeToFit()
        ratioLabel.center = self.center
        
        self.addSubview(ratioLabel)
    }
}
