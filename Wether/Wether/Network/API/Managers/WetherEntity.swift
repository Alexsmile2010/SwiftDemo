//
//  WetherEntity.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import UIKit

protocol DateWrapper: Codable {
    var dt: TimeInterval? { get set }
}

extension DateWrapper {
    var date: Date? {
        if let dt = dt {
            return Date(timeIntervalSince1970: dt)
        }
        return nil
    }
}

// MARK: - Wether
struct WetherEntity: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: CurrentWether?
    let minutely: [MinutelyWether]?
    let hourly: [CurrentWether]?
    let daily: [DailyWether]?
    let alerts: [Alert]?
    
    var currentDate: String? {
        return current?.date?.customFormat(.EEdyyyy)
    }
    
    var currentTemperature: String? {
        guard let temp = current?.temp else {
            return "🌡 no data"
        }
        return "🌡 \(Int(temp)) ℃"
    }
    
    var currentHumidity: String? {
        guard let humidity = current?.humidity else {
            return "💧 no data"
        }
        
        return "💧 \(humidity) %"
    }
    
    var currentWind: String? {
        guard let wind = current?.windSpeed else {
            return "🌬 no data"
        }
        
        return "🌬 \(wind) M/S"
    }
    
    var currentWetherIconUrl: URL? {
        return current?.weather?.first?.iconUrl
    }
    
    var currentWetherDesc: String? {
        return current?.weather?.first?.description
    }
}

// MARK: - Alert
struct Alert: Codable {
    let senderName, event: String?
    let start, end: Int?
    let alertDescription: String?
    let tags: [String]?
}

// MARK: - Current
struct CurrentWether: Codable, DateWrapper {
    var dt: TimeInterval?
    let sunrise, sunset: TimeInterval?
    let temp, feelsLike: Double?
    let pressure, humidity: Int?
    let dewPoint, uvi: Double?
    let clouds, visibility: Int?
    let windSpeed: Double?
    let windDeg: Int?
    let weather: [WeatherInfo]?
    let rain: Rain?
    let windGust: Double?
    let pop: Double?
}

// MARK: - Rain
struct Rain: Codable {
    let the1H: Double?
}

// MARK: - Weather
struct WeatherInfo: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    
    var iconUrl: URL? {
        guard let icon = icon else {
            return nil
        }
        
        return URL(string: "http://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}

// MARK: - Daily
struct DailyWether: DateWrapper {
    var dt: TimeInterval?
    let sunrise: TimeInterval?
    let sunset: TimeInterval?
    let moonset: TimeInterval?
    let moonrise: TimeInterval?
    let moonPhase: Double?
    let temp: Temp?
    let feelsLike: FeelsLike?
    let pressure, humidity: Int?
    let dewPoint, windSpeed: Double?
    let windDeg: Int?
    let weather: [WeatherInfo]?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
    let uvi: Double?
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    let day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double?
    let eve, morn: Double?
}

// MARK: - Minutely
struct MinutelyWether: DateWrapper {
    var dt: TimeInterval?
    let precipitation: Double?
}

