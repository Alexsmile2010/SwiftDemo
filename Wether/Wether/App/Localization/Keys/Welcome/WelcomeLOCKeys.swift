//
//  WelcomeLOCKeys.swift
//  Wether
//
//  Created by Alexey Zayakin on 31.03.2022.
//

import Foundation

enum WelcomeLOCKeys: String {
    case hello = "Welcome.hello"
    case welcomeMessage = "Welcome.titleMessage"
    case enableLocation = "Welcome.enableLocation"
}

extension WelcomeLOCKeys: LocalizableKeys {
    
    var value: String {
        return localized(withKey: self.rawValue)
    }
}

