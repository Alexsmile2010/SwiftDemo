//
//  DesignSystem+Colors.swift
//  DGTX
//
//  Created by Alexey Zayakin on 14.05.2021.
//

import UIKit

extension AppStyle {
    
    indirect enum Colors {
        case background(BackgroundColorType)
        case text(TextColorType)
        
        var color: UIColor {
            switch self {
            case .background(let type):
                return type.color
            case .text(let type):
                return type.color
            }
        }
        
        enum BackgroundColorType {
            case primary
            case secondary
            case white
            
            var color: UIColor {
                switch self {
                case .primary:
                    return #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
                case .secondary:
                    return #colorLiteral(red: 0.3529411765, green: 0.6235294118, blue: 0.9411764706, alpha: 1)
                case .white:
                    return .white
                }
            }
        }
        
        enum TextColorType {
            case white
            case black
            
            var color: UIColor {
                switch self {
                case .white:
                    return .white
                case .black:
                    return #colorLiteral(red: 0.1725490196, green: 0.1725490196, blue: 0.1725490196, alpha: 1)
                }
            }
        }
    }
}
