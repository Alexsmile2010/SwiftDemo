//
//  NetworkEnvironment.swift
//  Admin
//
//  Created by Serhii Palash on 20/01/2021.
//  Copyright © 2021 ForzaFC. All rights reserved.
//

import Foundation
import Combine

enum NetworkEnvironment {
    case development
}


// MARK: - Network reachability

extension NetworkEnvironment {
    static let reachabilitySubject = CurrentValueSubject<Bool, Never>(true)
}


//MARK: - API

extension NetworkEnvironment {
    var route: String {
        switch self {
        case .development:
            return "https://api.openweathermap.org"
        }
    }
}
