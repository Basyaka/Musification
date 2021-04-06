//
//  UIColor+Extension.swift
//  Musification
//
//  Created by Vlad Novik on 6.04.21.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let darkRed = UIColor.rgb(red: 139, green: 0, blue: 0)
}
