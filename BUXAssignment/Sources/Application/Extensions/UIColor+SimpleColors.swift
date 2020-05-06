//
//  UIColor+SimpleColors.swift
//  BUXAssignment
//
//  Created by Vladimir Ionița on 16/11/2017.
//  Copyright © 2017 Vladimir Ionița. All rights reserved.
//

import UIKit

extension UIColor {
    static let bxLightOrange = UIColor(withRGBRed: 251, green: 115, blue: 61, alpha: 10)
    static let bxDarkOrange = UIColor(withRGBRed: 251, green: 115, blue: 61, alpha: 100)
    static let bxGray = UIColor(withRGBWhite: 193, alpha: 30)
    static let bxGreen = UIColor(withRGBRed: 34, green: 139, blue: 34, alpha: 100)
    static let bxRed = UIColor(withRGBRed: 227, green: 38, blue: 54, alpha: 100)
    
    convenience init(withRGBRed: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(red: withRGBRed / 255.0,
                  green: green / 255.0,
                  blue: blue / 255.0,
                  alpha: alpha / 100.0)
    }
    
    convenience init(withRGBWhite: CGFloat, alpha: CGFloat) {
        self.init(white: withRGBWhite / 255.0,
                  alpha: alpha / 100.0)
    }
}
