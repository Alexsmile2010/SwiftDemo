//
//  MainViewModel.swift
//  Weather
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation

enum RequestError {
    case timeout
    case other
    case none
}


final class MainViewControllerViewModel: CancelableViewModel  {
    
    private var location: CLLocation
    private let networkManager = WeatherNetworkManager()
    private var data: WeatherEntity?
    
    var onDidFinishLoading:((_ error: RequestError) -> Void)?
    var onNeedToReloadWeatherLocationData:((_ data: WeatherLocationInfoData) -> Void)?
    var onNeedToReloadCurrentWeatherData: ((_ data: CurrentWeatherDisplayData) -> Void)?
    var onNeedToRealoadHourlyWeatherData: ((_ data: HourlyWeatherInfoViewModel) -> Void)?
    var onNeedToRealoadDailyWeatherData: ((_ data: DailyWeatherViewModel) -> Void)?
    
    
    
    init(with location: CLLocation) {
        self.location = location
    }
}

//MARK: - Public

extension MainViewControllerViewModel {
    
    func getWeather() {
        networkManager
            .getWeather(from: location)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.handleError(error)
                default:
                    break
                }
        } receiveValue: { [weak self] weatherData in
            self?.handleRequestResponse(with: weatherData)
        }
        .store(in: &bag)
    }
    
    func hourlyInfoViewModel() -> HourlyWeatherInfoViewModel {
        let hourlyData = data?.hourly
        let viewModel = HourlyWeatherInfoViewModel(with: hourlyData)
        return viewModel
    }
}

//MARK: - Private

extension MainViewControllerViewModel {
    private func handleRequestResponse(with data: WeatherEntity) {
        buildWeatherLocationInfoData(from: data)
        buildCurrentWeatherDisplayData(from: data.current)
        buildHourlyWeatherViewModel(from: data.hourly)
        buildDailyWeatherViewModel(from: data.daily)
    }
    
    private func buildWeatherLocationInfoData(from data: WeatherEntity) {
        let location = data.timezone
        let date = data.current?.date?.customFormat(.EEdyyyy)
        let weatherLocationInfoData = WeatherLocationInfoData(location: location,
                                                            date: date)
        onNeedToReloadWeatherLocationData?(weatherLocationInfoData)
    }
    
    private func buildCurrentWeatherDisplayData(from data: CurrentWeather?) {
        var currentTemperature: String = ""
        var currentHumidity: String = ""
        var currentWind: String = ""
        let iconUrl: URL? = data?.weather?.first?.iconUrl
        let description = data?.weather?.first?.description
        
        if let temp = data?.temp {
            currentTemperature = "🌡 \(Int(temp)) ℃"
        } else {
            currentTemperature = "🌡 no data"
        }
        
        if let humidity = data?.humidity {
            currentHumidity = "💧 \(humidity) %"
        } else {
            currentHumidity = "💧 no data"
        }
        
        if let wind = data?.windSpeed {
            currentWind = "🌬 \(wind) м/с"
        } else {
            currentWind = "🌬 no data"
        }
        
        let currentWeatherData = CurrentWeatherDisplayData(temperature: currentTemperature,
                                                         humidity: currentHumidity,
                                                         wind: currentWind,
                                                         iconUrl: iconUrl,
                                                         description: description)
        onNeedToReloadCurrentWeatherData?(currentWeatherData)
    }
    
    private func buildHourlyWeatherViewModel(from data: [CurrentWeather]?)  {
        let viewModel = HourlyWeatherInfoViewModel(with: data)
        onNeedToRealoadHourlyWeatherData?(viewModel)
    }
    
    private func buildDailyWeatherViewModel(from data: [DailyWeather]?)  {
        let viewModel = DailyWeatherViewModel(with: data)
        onNeedToRealoadDailyWeatherData?(viewModel)
    }
    
    private func handleError(_ error: NetworkError) {
        switch error {
        case .urlError(let uRLError):
            switch uRLError.code {
            case .timedOut:
                onDidFinishLoading?(.timeout)
            default:
                onDidFinishLoading?(.other)
            }
        default:
            onDidFinishLoading?(.other)
        }
    }
}
