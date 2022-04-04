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
    case updateLocation = "Welcome.updateLocation"
    case selectLocation = "Welcome.selectLocation"
    case errorAlertTitle = "Welcome.errorAlertTitle"
    case errorAlertDesc = "Welcome.errorAlertDesc"
    case errorAlertSearchButton = "Welcome.errorAlertSeacrhButton"
    case errorAlertSkipButton = "Welcome.errorAlertSkipButton"
    case nextButton = "Welcome.nextButtonTitle"
}

extension WelcomeLOCKeys: LocalizableKeys {
    
    var value: String {
        return localized(withKey: self.rawValue)
    }
}

