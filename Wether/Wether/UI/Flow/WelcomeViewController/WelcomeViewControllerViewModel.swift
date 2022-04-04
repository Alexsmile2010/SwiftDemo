//
//  WelcomeViewControllerViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 01.04.2022.
//

import Foundation
import Combine

final class WelcomeViewControllerViewModel {
    
    private let locationManager = LocationManager()
    
    var onDidReceiveUserLocation: ((_ location: String?) -> Void)?
    var onDidChangeAuthorizationStatus: ((_ locKey: LOCKey) -> Void)?
    var onDidFailReceivePermissionOrLocation: (() -> Void)?
    
    var nextButtonIsHidden = CurrentValueSubject<Bool, Never>(true)
    
    var mainScreenTransitionSettings: RootTransitionSettings {
        let location = locationManager.wetherLocation()
        let viewModel = MainViewControllerViewModel(with: location)
        return RootTransitionSettings(destinationType: .main(viewModel),
                               basedOnNavigatonController: true)
    }
    
    init() {
        locationManager.delegate = self
    }
}
 
//MARK: - Public

extension WelcomeViewControllerViewModel {
    
    func requestLocationStatus() {
        locationManager.requestUserLocation()
    }
}

//MARK: - Private

extension WelcomeViewControllerViewModel {
    
    private func handleFetchedCity(_ city: String?) {
        if let city = city {
            let userLocation = "Your location is: \(city)"
            onDidReceiveUserLocation?(userLocation)
            nextButtonIsHidden.send(false)
        } else {
            onDidReceiveUserLocation?("Your location not found")
            nextButtonIsHidden.send(true)
        }
    }
    
    private func handleLocationManagerAuthorizationStatus(_ status: LocationManager.LocationManagerStatus) {
        switch status {
        case .enable:
            onDidChangeAuthorizationStatus?(.welcome(.updateLocation))
        case .disable:
            onDidChangeAuthorizationStatus?(.welcome(.enableLocation))
        case .notAllowed:
            onDidChangeAuthorizationStatus?(.welcome(.selectLocation))
        }
    }
}

//MARK: - LocationManagerDelegate
extension WelcomeViewControllerViewModel: LocationManagerDelegate {
    
    func locationManagerDidChangeLocationStatus(_ status: LocationManager.LocationManagerStatus) {
        handleLocationManagerAuthorizationStatus(status)
    }
    
   
    func locationManagerDidFinishWithError(_ error: Error) {
        
    }
    
    func locationManagerDidFetchLocation(with city: String?) {
        handleFetchedCity(city)
    }
}
