//
//  WeatherEntity.swift
//  Weather
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

// MARK: - Weather
struct WeatherEntity: Codable {
    let lat, lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let current: CurrentWeather?
    let minutely: [MinutelyWeather]?
    let hourly: [CurrentWeather]?
    let daily: [DailyWeather]?
    let alerts: [Alert]?

}

// MARK: - Alert
struct Alert: Codable {
    let senderName, event: String?
    let start, end: Int?
    let alertDescription: String?
    let tags: [String]?
}

// MARK: - Current
struct CurrentWeather: Codable, DateWrapper {
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
struct DailyWeather: DateWrapper {
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
struct MinutelyWeather: DateWrapper {
    var dt: TimeInterval?
    let precipitation: Double?
}

