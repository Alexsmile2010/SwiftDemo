//
//  UIButton+Extension.swift
//  DGTX
//
//  Created by Alexey Zayakin on 19.05.2021.
//

import UIKit

extension UIButton {
    
    func applyFontStyle(_ style: FontStyle) {
        titleLabel?.font = style.font
        setTitleColor(style.fontColor, for: .normal)
    }
    
    func loadingIndicator(_ show: Bool) {
        let uniqueTag = 123456
        if show {
            self.isEnabled = false
            let indicator = UIActivityIndicatorView()
            indicator.color = AppStyle.Colors.background(.primary).color
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = uniqueTag
            self.addSubview(indicator)
            indicator.startAnimating()
        } else {
            self.isEnabled = true
            if let indicator = self.viewWithTag(uniqueTag) as? UIActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
