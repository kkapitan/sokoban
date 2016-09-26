//
//  Colors.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

extension UIColor {
    static func levelCompletedBorderColor() -> UIColor {
        return UIColor(hex: 0x979797)
    }
    
    static func shadowColor() -> UIColor {
        return UIColor(hex: 0x000000, alpha: 0.9)
    }
    
    static func goldBoxColor() -> UIColor {
        return UIColor(hex: 0xC7C523)
    }

    
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(hex netHex: Int, alpha: CGFloat = 1.0) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, a: alpha)
    }
}
