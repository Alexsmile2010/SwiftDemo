//
//  OpenAPIRoutes.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation

enum OpenAPIRoutes {
    case wether(CLLocation)
}

extension OpenAPIRoutes: EndPointType {
    
    var environmentBaseURL: String? {
        return NetworkConfiguration.environment.route
    }
    
    var baseUrl: URL? {
        return environmentBaseURL.flatMap(URL.init(string:))
    }
    
    var path: String {
        switch self {
        case .wether(let location):
            return "/data/2.5/onecall?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&units=metric&lang=ua&appid=\(Global.wetherAPIKey)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders? {
        return NetworkConfiguration.defaultHeaders
    }
    
    var isAuthorizationRequired: Bool {
        false
    }
    
    var isTokensRefreshImplied: Bool {
        false
    }
}
