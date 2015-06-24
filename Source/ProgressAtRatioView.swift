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

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func initialize(frame: CGRect) {
        
        let rect: CGRect = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        if let prop = prop {
            // Base Circular
            let circular: ArcView = ArcView(frame: rect, lineWidth: prop.baseLineWidth)
            circular.prop = prop
            circular.ratio = 1.0
            circular.color = prop.baseArcColor
            circular.lineWidth = prop.baseLineWidth
            self.addSubview(circular)
            
            // Gradient Circular
            let gradient = GradientArcView(frame: rect)
            gradient.prop = prop
            self.addSubview(gradient)
            
            // Mask
            mask = ArcView(frame: rect, lineWidth: prop.arcLineWidth)
            if let mask = mask {
                mask.prop = prop
                let maskView = mask
                maskView.frame = mask.frame
                gradient.layer.mask = maskView.layer
            }
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        if let mask = mask {
            
            if ratio > 1.0 {
                mask.ratio = 1.0
            } else {
                mask.ratio = ratio
            }
            mask.setNeedsDisplay()
        }
    }
    
    func showRatio() {
                
        if let prop = prop {
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
}
