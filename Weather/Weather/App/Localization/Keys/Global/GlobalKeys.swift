//
//  GlobalKeys.swift
//  DGTX
//
//  Created by Alexey Zayakin on 13.05.2021.
//

import Foundation

enum GlobalLOCKeys {
    case common(GlobalCommonLOCKeys)
}

enum GlobalCommonLOCKeys: String {
    case welcome = "Global.welcome"
    case retry = "Global.retry"
}


extension GlobalLOCKeys: LocalizableKeys {
    
    var value: String {
        switch self {
        case .common(let key):
            return localized(withKey: key.rawValue)
        }
    }
}
