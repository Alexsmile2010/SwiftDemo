//
//  StringExt.swift
//  Blockster
//
//  Created by Edward Gray on 26.02.2021.
//

import Foundation
import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
    func isNumber() -> Bool {
        let num = Int(self)
        return num != nil
    }
}
