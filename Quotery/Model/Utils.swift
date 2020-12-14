//
//  Utils.swift
//  Quotery
//
//  Created by Admin on 12/1/20.
//

import Foundation
import Social

class Utils {
/* MARK: Images
/////////////////////////////////////////// */
func imageResize (_ image:UIImage, sizeChange:CGSize) -> UIImage{
    let hasAlpha = true
    let scale: CGFloat = 0.0 // Use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
    image.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    return scaledImage!
}

}
