//
//  MainViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation

final class MainViewControllerViewModel: CancelableViewModel  {
    
    private var location: CLLocation
    private let networkManager = WetherNetworkManager()
    private var data: WetherEntity?
    
    var onNeedToReloadWetherLocationData:((_ data: WetherLocationInfoData) -> Void)?
    var onNeedToReloadCurrentWetherData: ((_ data: CurrentWetherDisplayData) -> Void)?
    var onNeedToRealoadHourlyWetherData: ((_ data: HourlyWetherInfoViewModel) -> Void)?
    
    init(with location: CLLocation) {
        self.location = location
    }
}

//MARK: - Public

extension MainViewControllerViewModel {
    
    func getWether() {
        networkManager
            .getWether(from: location)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                default:
                    break
                }
        } receiveValue: { [weak self] wetherData in
            self?.handleRequestResponse(with: wetherData)
        }
        .store(in: &bag)
    }
    
    func hourlyInfoViewModel() -> HourlyWetherInfoViewModel {
        let hourlyData = data?.hourly
        let viewModel = HourlyWetherInfoViewModel(with: hourlyData)
        return viewModel
    }
}

//MARK: - Private

extension MainViewControllerViewModel {
    private func handleRequestResponse(with data: WetherEntity) {
        buildWetherLocationInfoData(from: data)
        buildCurrentWetherDisplayData(from: data.current)
        buildHourlyWetherViewModel(from: data.hourly)
    }
    
    private func buildWetherLocationInfoData(from data: WetherEntity) {
        let location = data.timezone
        let date = data.current?.date?.customFormat(.EEdyyyy)
        let wetherLocationInfoData = WetherLocationInfoData(location: location,
                                                            date: date)
        onNeedToReloadWetherLocationData?(wetherLocationInfoData)
    }
    
    private func buildCurrentWetherDisplayData(from data: CurrentWether?) {
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
        
        let currentWetherData = CurrentWetherDisplayData(temperature: currentTemperature,
                                                         humidity: currentHumidity,
                                                         wind: currentWind,
                                                         iconUrl: iconUrl,
                                                         description: description)
        onNeedToReloadCurrentWetherData?(currentWetherData)
    }
    
    private func buildHourlyWetherViewModel(from data: [CurrentWether]?)  {
        let viewModel = HourlyWetherInfoViewModel(with: data)
        onNeedToRealoadHourlyWetherData?(viewModel)
    }
}
