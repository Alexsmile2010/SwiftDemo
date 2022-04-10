//
//  HourlyWetherInfoViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 10.04.2022.
//

import Foundation
import CoreGraphics.CGGeometry

final class HourlyWetherInfoViewModel {
    private var hourlyData: [CurrentWether]?
    
    var collectioViewCellSize: CGSize {
        return CGSize(width: 50, height: 80)
    }
    
    init(with data: [CurrentWether]?) {
        hourlyData = data
    }
}

//MARK: - Public

extension HourlyWetherInfoViewModel {
    
    func hurlyDisplayData(at indexPath: IndexPath) -> HurlyDisplayData {
        let hourlyWetherItem = hourlyData?[indexPath.row]
        let hour = hourlyWetherItem?.date?.customFormat(.HHmm)
        let url = hourlyWetherItem?.weather?.first?.iconUrl
        var temperature: String = "No data"
        
        if let temp = hourlyWetherItem?.temp {
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

extension HourlyWetherInfoViewModel: ListDataSource {
    
    func numberOfRowsIn(section: Int) -> Int {
        return hourlyData?.count ?? 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
}
