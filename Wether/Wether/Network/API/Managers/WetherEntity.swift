//
//  WetherEntity.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation

// MARK: - Wether
struct Wether {
    let lat, lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWether
    let minutely: [MinutelyWether]
    let hourly: [CurrentWether]
    let daily: [DailyWether]
    let alerts: [Alert]
}

// MARK: - Alert
struct Alert {
    let senderName, event: String
    let start, end: Int
    let alertDescription: String
    let tags: [String]
}

// MARK: - Current
struct CurrentWether {
    let dt: Int
    let sunrise, sunset: Int?
    let temp, feelsLike: Double
    let pressure, humidity: Int
    let dewPoint, uvi: Double
    let clouds, visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [WeatherInfo]
    let rain: Rain?
    let windGust: Double?
    let pop: Int?
}

// MARK: - Rain
struct Rain {
    let the1H: Double
}

// MARK: - Weather
struct WeatherInfo {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String
}

// MARK: - Daily
struct DailyWether {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonset: Int
    let moonrise: Int
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let dewPoint, windSpeed: Double
    let windDeg: Int
    let weather: [WeatherInfo]
    let clouds: Int
    let pop: Double
    let rain: Double
    let uvi: Double
}

// MARK: - FeelsLike
struct FeelsLike {
    let day, night, eve, morn: Double
}

// MARK: - Temp
struct Temp {
    let day, min, max, night: Double
    let eve, morn: Double
}

// MARK: - Minutely
struct MinutelyWether {
    let dt: Int
    let precipitation: Double
}

