//
//  LocalizationManager.swift
//  DGTX
//
//  Created by Alexey Zayakin on 29.04.2021.
//

import Foundation

//MARK: - LocalizableKeys
protocol LocalizableKeys {
    
    ///value with ready to use localization string
    var value: String { get }
    
    func localized(withKey key: String) -> String
}

extension LocalizableKeys {
    func localized(withKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    func localized(with key: String, format: CVarArg...) -> String {
        return String(format: NSLocalizedString(key, comment: ""), arguments: format)
    }
}

//MARK: - LOCKey
enum LOCKey {
    case string(String)
    case global(GlobalLOCKeys)
    case welcome(WelcomeLOCKeys)
}

extension LOCKey {
    var localized: String {
        return LOCService.localize(with: self)
    }
}

struct LOCService {
    static func localize(with key: LOCKey) -> String {
        switch key {
        case .string(let value):
            return value
        case .global(let key):
            return key.value
        case .welcome(let key):
            return key.value
        }
    }
}







