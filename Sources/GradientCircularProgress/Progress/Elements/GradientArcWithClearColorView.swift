//
//  GradientArcWithClearColorView.swift
//  GradientCircularProgress
//
//  Created by keygx on 2015/11/20.
//  Copyright (c) 2015年 keygx. All rights reserved.
//

import UIKit

class GradientArcWithClearColorView: UIView {
    
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
        startGradientMaskProp.startArcColor = UIColor.black
        startGradientMaskProp.endArcColor = UIColor.white
        startGradientMaskProp.progressSize += 10.0
        startGradientMaskProp.arcLineWidth += 20.0
        
        // EndGradientMask
        endGradientMaskProp.startArcColor = UIColor.white
        endGradientMaskProp.endArcColor = UIColor.black
        endGradientMaskProp.progressSize += 10.0
        endGradientMaskProp.arcLineWidth += 20.0

        // SolidMask
        solidMaskProp.startArcColor = UIColor.black
        solidMaskProp.endArcColor   = UIColor.black
        
        /* Mask Image */
        // StartArcColorImage
        let startArcColorView = ArcView(frame: rect, lineWidth: startArcColorProp.arcLineWidth)
        startArcColorView.color = startArcColorProp.startArcColor
        startArcColorView.prop = startArcColorProp
        let startArcColorImage = viewToUIImage(view: startArcColorView)!
        
        // StartGradientMaskImage
        let startGradientMaskView = GradientArcView(frame: rect)
        startGradientMaskView.prop = startGradientMaskProp
        let startGradientMaskImage = viewToUIImage(view: startGradientMaskView)!
        
        // EndArcColorImage
        let endArcColorView = ArcView(frame: rect, lineWidth: endArcColorProp.arcLineWidth)
        endArcColorView.color = endArcColorProp.startArcColor
        endArcColorView.prop = endArcColorProp
        let endArcColorImage = viewToUIImage(view: endArcColorView)!
        
        // EndGradientMaskImage
        let endGradientMaskView = GradientArcView(frame: rect)
        endGradientMaskView.prop = endGradientMaskProp
        let endGradientMaskImage = viewToUIImage(view: endGradientMaskView)!
        
        // SolidMaskImage
        let solidMaskView = ArcView(frame: rect, lineWidth: solidMaskProp.arcLineWidth)
        solidMaskView.prop = solidMaskProp
        let solidMaskImage = viewToUIImage(view: solidMaskView)!
        
        /* Masking */
        var startArcImage = mask(image: startGradientMaskImage, maskImage: solidMaskImage)
        startArcImage = mask(image: startArcColorImage, maskImage: startArcImage)
        
        var endArcImage = mask(image: endGradientMaskImage, maskImage: solidMaskImage)
        endArcImage = mask(image: endArcColorImage, maskImage: endArcImage)
        
        /* Composite */
        let image: UIImage = composite(image1: startArcImage, image2: endArcImage, prop: prop)
        
        /* UIImageView */
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }
    
    internal func mask(image: UIImage, maskImage: UIImage) -> UIImage {
        
        let maskRef: CGImage = maskImage.cgImage!
        let mask: CGImage = CGImage(
            maskWidth: maskRef.width,
            height: maskRef.height,
            bitsPerComponent: maskRef.bitsPerComponent,
            bitsPerPixel: maskRef.bitsPerPixel,
            bytesPerRow: maskRef.bytesPerRow,
            provider: maskRef.dataProvider!,
            decode: nil,
            shouldInterpolate: false)!
        
        let maskedImageRef: CGImage = image.cgImage!.masking(mask)!
        let scale = UIScreen.main.scale
        let maskedImage: UIImage = UIImage(cgImage: maskedImageRef, scale: scale, orientation: .up)
        
        return maskedImage
    }
    
    internal func viewToUIImage(view: UIView) -> UIImage? {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    internal func composite(image1: UIImage, image2: UIImage, prop: Property) -> UIImage {
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image1.size, false, scale)
        image1.draw(
            in: CGRect(x: 0, y: 0, width: image1.size.width, height: image1.size.height),
            blendMode: .overlay,
            alpha: ColorUtil.toRGBA(color: prop.startArcColor).a)
        image2.draw(
            in: CGRect(x: 0, y: 0, width: image2.size.width, height: image2.size.height),
            blendMode: .overlay,
            alpha: ColorUtil.toRGBA(color: prop.endArcColor).a)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
