//
//  DesignSystem+Fonts.swift
//  DGTX
//
//  Created by Alexey Zayakin on 14.05.2021.
//

import Foundation
import UIKit

typealias DSFont = (name: AppStyle.FontName, size: AppStyle.FontSize)

extension UIFont {
    convenience init(style: DSFont) {
        let descriptor = UIFontDescriptor(name: style.name.font, size: style.size.rawValue)
        self.init(descriptor: descriptor, size: style.size.rawValue)
    }
}

extension AppStyle {
    
    enum Font {
        case heading(HeadingFontType)
        case text(TextFontType)
        
        var font: UIFont {
            switch self {
            case .heading(let type):
                return UIFont(style: type.style)
            case .text(let type):
                return UIFont(style: type.style)
            }
        }
    }
    
    enum FontName {
        case poppins(PoppinsFontType)
        
        var font: String {
            switch self {
            case .poppins(let type):
                return type.rawValue
            }
        }
    }
    
    enum PoppinsFontType: String {
        case regular = "Poppins-Regular"
        case medium = "Poppins-Medium"
        case italic = "Poppins-Italic"
        case semiBold = "Poppins-SemiBold"
    }
    
    enum FontSize: CGFloat {
        case size38 = 38.0
        case size32 = 32.0
        case size28 = 28.0
        case size24 = 24.0
        case size22 = 22.0
        case size20 = 20.0
        case size18 = 18.0
        case size16 = 16.0
        case size14 = 14.0
        case size12 = 12.0
        case size11 = 11.0
    }
    
    enum HeadingFontType {
        case headline38
        case headline24
        case headline18
        
        
        var style: DSFont {
            switch self {
            case .headline38:
                return (.poppins(.semiBold), .size38)
            case .headline24:
                 return (.poppins(.medium), .size24)
            case .headline18:
                return (.poppins(.medium), .size18)
            }
        }
    }
    
    enum TextFontType {
        case text14
        case text18
        case text28
        
        var style: DSFont {
            switch self {
            case .text14:
                return (.poppins(.regular), .size14)
            case .text18:
                return (.poppins(.regular), .size18)
            case .text28:
                return (.poppins(.regular), .size28)
            }
        }
    }
    
   
    
    enum BorderWidth {
        case normal
        
        var value: CGFloat {
            switch self {
            case .normal:   return 2
            }
        }
    }

}
