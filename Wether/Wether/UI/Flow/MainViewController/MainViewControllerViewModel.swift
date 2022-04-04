//
//  MainViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 04.04.2022.
//

import Foundation
import CoreLocation

final class MainViewControllerViewModel {
    
    private var location: CLLocation
    
    init(with location: CLLocation) {
        self.location = location
    }
}
