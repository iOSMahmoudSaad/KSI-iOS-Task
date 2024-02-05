//
//  TextField + Extension.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//


import UIKit
 
@IBDesignable extension UITextField {
    
    func setPlaceHolderColor(_ color:UIColor,_ font:UIFont? = nil){
        if let font {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ?  self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color,.font: font])
        }else{
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ?  self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
        }
    }

}
