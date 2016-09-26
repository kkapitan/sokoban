//
//  ViewExtensions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

extension UIView {
    
    func addBorder(color: UIColor, width: CGFloat) {
       layer.borderColor = color.CGColor
       layer.borderWidth = width
    }
    
    func roundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func rotate(degree: CGFloat) {
        transform = CGAffineTransformRotate(transform, CGFloat(M_PI) * (degree / 180.0))
    }
    
    func makeShadow(color: UIColor = UIColor.shadowColor(), offset: CGSize) {
        layer.shadowColor = color.CGColor
        layer.shadowOffset = offset
        layer.shadowOpacity = 0.5
    }
}