//
//  Color + Extension.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit

extension UIColor {

    @nonobjc class var lavenderPurple: UIColor {
        return UIColor(named: "lavender purple")!
    }
    @nonobjc class var MediumGray:UIColor {
        return UIColor(named: "Medium gray")!
    }
    @nonobjc class var Gray6:UIColor {
        return UIColor(named: "Gray6")!
    }
    @nonobjc class var DarkGray:UIColor {
        return UIColor(named: "DarkGray")!
    }
    @nonobjc class var Gray2:UIColor {
        return UIColor(named: "Gray2")!
    }
    convenience init?(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        guard hexValue.count == 6 else {
            return nil
        }
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
