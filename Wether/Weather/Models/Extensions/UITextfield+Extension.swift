//
//  UITextfield+Extension.swift
//  DGTX
//
//  Created by Alexey Zayakin on 17.05.2021.
//

import Foundation
import UIKit

extension UITextField {
    
    func applyFontStyle(_ style: FontStyle) {
        font = style.font
        textColor = style.fontColor
    }
}
