//
//  WelcomeViewControllerViewModel.swift
//  Wether
//
//  Created by Alexey Zayakin on 01.04.2022.
//

import Foundation

final class WelcomeViewControllerViewModel {
    
    private let locationManager = LocationManager()
    
    var onDidReceiveUserLocation: ((_ location: String?) -> Void)?
    var onDidChangeAuthorizationStatus: ((_ locKey: LOCKey) -> Void)?
    
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
        } else {
            onDidReceiveUserLocation?("Your location not found")
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
