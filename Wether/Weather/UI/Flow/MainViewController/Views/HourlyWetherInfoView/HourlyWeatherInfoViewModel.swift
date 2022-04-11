//
//  HourlyWeatherInfoViewModel.swift
//  Weather
//
//  Created by Alexey Zayakin on 10.04.2022.
//

import Foundation
import CoreGraphics.CGGeometry

final class HourlyWeatherInfoViewModel {
    private var hourlyData: [CurrentWeather]?
    
    var collectioViewCellSize: CGSize {
        return CGSize(width: 50, height: 80)
    }
    
    init(with data: [CurrentWeather]?) {
        hourlyData = data
    }
}

//MARK: - Public

extension HourlyWeatherInfoViewModel {
    
    func hurlyDisplayData(at indexPath: IndexPath) -> HurlyDisplayData {
        let hourlyWeatherItem = hourlyData?[indexPath.row]
        let hour = hourlyWeatherItem?.date?.customFormat(.HHmm)
        let url = hourlyWeatherItem?.weather?.first?.iconUrl
        var temperature: String = "No data"
        
        if let temp = hourlyWeatherItem?.temp {
            let tempInt = Int(temp)
            temperature = "\(tempInt) ℃"
        }
        
        let displayData = HurlyDisplayData(hour: hour,
                                           temperature: temperature,
                                           iconUrl: url)
        return displayData
    }
}

//MARK: - ListDataSource

extension HourlyWeatherInfoViewModel: ListDataSource {
    
    func numberOfRowsIn(section: Int) -> Int {
        return hourlyData?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
}
