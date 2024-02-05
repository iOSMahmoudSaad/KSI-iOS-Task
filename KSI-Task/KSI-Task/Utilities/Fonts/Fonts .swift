//
//  Fonts .swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

 
import UIKit

class Fonts {
    
    private enum FontName {
        
        case Regular(String)
        case Light(String)
        case Bold(String)
        case SemiBold(String)
        case Medium(String)
        case Thin(String)
        case ExtraBold(String)
    }
    
    private static func customFont(font: FontName, size: CGFloat) -> UIFont {
        
        let fontName: String
        
        switch font {
        case .Regular(let name):
            fontName = name + "-Regular"
        case .Light(let name):
            fontName = name + "-Light"
        case .Bold(let name):
            fontName = name + "-Bold"
        case .SemiBold(let name):
            fontName = name + "-SemiBold"
        case .Medium(let name):
            fontName = name + "-Medium"
        case .Thin(let name):
            fontName = name + "-Thin"
        case .ExtraBold(let name):
            fontName = name + "-ExtraBold"
        }
        
        guard let customFont = UIFont(name: fontName, size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
    
    static func regular(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Regular(name), size: size)
    }
    
    static func light(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Light(name), size: size)
    }
    
    static func bold(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Bold(name), size: size)
    }
    
    static func semiBold(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .SemiBold(name), size: size)
    }
    
    static func medium(name: String, size: CGFloat) -> UIFont {
        return customFont(font: .Medium(name), size: size)
    }
    
}

class FontSize {
    static let fontTiny : CGFloat = 8
    static let fontSmall : CGFloat = 11
    static let fontRegular : CGFloat = 14
    static let fontMedium : CGFloat = 16
    static let fontSmiLarg : CGFloat = 18
    static let fontLarge : CGFloat = 20
    static let fontTwintyTwo: CGFloat = 22
    static let fontTwintyFour: CGFloat = 24
    static let fontVeryLarge : CGFloat = 28
    static let fontThirty: CGFloat = 30
    static let fontThirtyFour:CGFloat = 34
    static let sizeFifteen:CGFloat = 15
}
