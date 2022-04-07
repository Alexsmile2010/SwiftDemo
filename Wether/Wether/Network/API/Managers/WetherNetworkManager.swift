//
//  WetherManager.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation
import Combine

struct WetherNetworkManager {
    let manager =  NetworkRouter<OpenAPIRoutes>()
    
    func getWether(from location: CLLocation) -> AnyPublisher<WetherEntity, NetworkError> {
        manager.makeDataRequest(.wether(location))
    }
    
}
