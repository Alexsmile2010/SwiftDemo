//
//  DailyWeatherViewModel.swift
//  Weather
//
//  Created by Alexey Zayakin on 11.04.2022.
//

import Foundation

struct DailyDisplayInfoData {
    let day: String?
    let temperature: String?
    let iconUrl: URL?
}

final class DailyWeatherViewModel {
    
    private let data: [DailyWeather]?
    
    init(with data: [DailyWeather]?) {
        self.data = data
    }
}

//MARK: - Public

extension DailyWeatherViewModel {
    
    func dailyData(at indexPath: IndexPath) -> DailyDisplayInfoData {
        let item = data?[indexPath.row]
        
        let day = item?.date?.customFormat(.EE)
        
        var temperature: String = ""
        
        if
            let min = item?.temp?.min,
            let max = item?.temp?.max {
            temperature = "\(Int(min))...\(Int(max)) ℃"
        }
        
        let iconUrl = item?.weather?.first?.iconUrl
        let dailyDisplayInfo = DailyDisplayInfoData(day: day,
                                                    temperature: temperature,
                                                    iconUrl: iconUrl)
        return dailyDisplayInfo
    }
}

//MARK: - ListDataSource

extension DailyWeatherViewModel: ListDataSource {
    func numberOfRowsIn(section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
}
