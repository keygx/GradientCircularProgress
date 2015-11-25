//
//  GradientArcWithClearColorView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/11/20.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import Foundation
import UIKit

class GradientArcWithClearColorView : UIView {
    
    internal func draw(rect: CGRect, prop: Property) -> UIImageView {
        // Gradient Clear Circular
        
        /* Prop */
        var startArcColorProp = prop
        var endArcColorProp = prop
        var startGradientMaskProp = prop
        var endGradientMaskProp = prop
        var solidMaskProp = prop
        
        // StartArc
        startArcColorProp.endArcColor = ColorUtil.toNotOpacityColor(color: startArcColorProp.startArcColor)
        
        // EndArc
        endArcColorProp.startArcColor = ColorUtil.toNotOpacityColor(color: endArcColorProp.endArcColor)
        
        // StartGradientMask
        startGradientMaskProp.startArcColor = UIColor.blackColor()
        startGradientMaskProp.endArcColor = UIColor.whiteColor()
        startGradientMaskProp.progressSize += 10.0
        startGradientMaskProp.arcLineWidth += 20.0
        
        // EndGradientMask
        endGradientMaskProp.startArcColor = UIColor.whiteColor()
        endGradientMaskProp.endArcColor = UIColor.blackColor()
        endGradientMaskProp.progressSize += 10.0
        endGradientMaskProp.arcLineWidth += 20.0

        // SolidMask
        solidMaskProp.startArcColor = UIColor.blackColor()
        solidMaskProp.endArcColor   = UIColor.blackColor()
        
        /* Mask Image */
        // StartArcColorImage
        let startArcColorView = ArcView(frame: rect, lineWidth: startArcColorProp.arcLineWidth)
        startArcColorView.color = startArcColorProp.startArcColor
        startArcColorView.prop = startArcColorProp
        let startArcColorImage = viewToUIImage(startArcColorView)!
        
        // StartGradientMaskImage
        let startGradientMaskView = GradientArcView(frame: rect)
        startGradientMaskView.prop = startGradientMaskProp
        let startGradientMaskImage = viewToUIImage(startGradientMaskView)!
        
        // EndArcColorImage
        let endArcColorView = ArcView(frame: rect, lineWidth: endArcColorProp.arcLineWidth)
        endArcColorView.color = endArcColorProp.startArcColor
        endArcColorView.prop = endArcColorProp
        let endArcColorImage = viewToUIImage(endArcColorView)!
        
        // EndGradientMaskImage
        let endGradientMaskView = GradientArcView(frame: rect)
        endGradientMaskView.prop = endGradientMaskProp
        let endGradientMaskImage = viewToUIImage(endGradientMaskView)!
        
        // SolidMaskImage
        let solidMaskView = ArcView(frame: rect, lineWidth: solidMaskProp.arcLineWidth)
        solidMaskView.prop = solidMaskProp
        let solidMaskImage = viewToUIImage(solidMaskView)!
        
        /* Masking */
        var startArcImage = mask(startGradientMaskImage, maskImage: solidMaskImage)
        startArcImage = mask(startArcColorImage, maskImage: startArcImage)
        
        var endArcImage = mask(endGradientMaskImage, maskImage: solidMaskImage)
        endArcImage = mask(endArcColorImage, maskImage: endArcImage)
        
        /* Composite */
        let image: UIImage = composite(image1: startArcImage, image2: endArcImage, prop: prop)
        
        /* UIImageView */
        let imageView = UIImageView(image: image)
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    internal func mask(image: UIImage, maskImage: UIImage) -> UIImage {
        
        let maskRef: CGImageRef = maskImage.CGImage!
        let mask: CGImageRef = CGImageMaskCreate(
            CGImageGetWidth(maskRef),
            CGImageGetHeight(maskRef),
            CGImageGetBitsPerComponent(maskRef),
            CGImageGetBitsPerPixel(maskRef),
            CGImageGetBytesPerRow(maskRef),
            CGImageGetDataProvider(maskRef),
            nil,
            false)!
        
        let maskedImageRef: CGImageRef = CGImageCreateWithMask(image.CGImage, mask)!
        let scale = UIScreen.mainScreen().scale
        let maskedImage: UIImage = UIImage.init(CGImage: maskedImageRef, scale: scale, orientation: .Up)
        
        return maskedImage
    }
    
    internal func viewToUIImage(view: UIView) -> UIImage? {
        
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, scale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    internal func composite(image1 image1: UIImage, image2: UIImage, prop: Property) -> UIImage {
        
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(image1.size, false, scale)
        image1.drawInRect(
            CGRectMake(0, 0, image1.size.width, image1.size.height),
            blendMode: .Overlay,
            alpha: ColorUtil.toRGBA(color: prop.startArcColor).a)
        image2.drawInRect(
            CGRectMake(0, 0, image2.size.width, image2.size.height),
            blendMode: .Overlay,
            alpha: ColorUtil.toRGBA(color: prop.endArcColor).a)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
