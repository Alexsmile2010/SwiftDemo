//
//  ErrorKeys.swift
//  Weather
//
//  Created by Alexey Zayakin on 11.04.2022.
//

import Foundation

enum ErrorLOCKeys: String {
    case timeout = "Error.timeout"
    case requestError = "Error.requestError"
}

extension ErrorLOCKeys: LocalizableKeys {
    
    var value: String {
        return localized(withKey: self.rawValue)
    }
}
