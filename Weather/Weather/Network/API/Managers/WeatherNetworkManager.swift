//
//  WeatherManager.swift
//  Weather
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation
import Combine

struct WeatherNetworkManager {
    let manager =  NetworkRouter<OpenAPIRoutes>()
    
    func getWeather(from location: CLLocation) -> AnyPublisher<WeatherEntity, NetworkError> {
        manager.makeDataRequest(.weather(location))
    }
    
}
