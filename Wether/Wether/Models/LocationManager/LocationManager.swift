//
//  LocationManager.swift
//  Wether
//
//  Created by Alexey Zayakin on 01.04.2022.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManagerDidFinishWithError(_ error: Error)
    func locationManagerDidFetchLocation(with city: String?)
    func locationManagerDidChangeLocationStatus(_ status: LocationManager.LocationManagerStatus)
}

final class LocationManager: NSObject {
    
    enum LocationManagerStatus {
        case enable
        case disable
        case notAllowed
    }
    
    private let manager = CLLocationManager()
    private var currentLocation: CLLocation?
    private var currentPlace: CLPlacemark?
    
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    deinit {
        manager.stopUpdatingLocation()
    }
}

//MARK: - Public

extension LocationManager {
    
    func requestUserLocation() {
        switch manager.authorizationStatus {
        case .notDetermined:
            requestAuthorization()
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            scanLocation()
        default:
            print("error")
        }
    }
    
    func wetherLocation() -> CLLocation {
        if let currentLocation = currentLocation {
            return currentLocation
        } else {
            return Global.defaultLocation
        }
    }
}

//MARK: - Private

extension LocationManager {
    
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            delegate?.locationManagerDidChangeLocationStatus(.disable)
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            delegate?.locationManagerDidChangeLocationStatus(.enable)
        default:
            delegate?.locationManagerDidChangeLocationStatus(.notAllowed)
        }
    }
    
    private func scanLocation() {
        manager.startUpdatingLocation()
    }
    
    private func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func handleLocation(_ location: CLLocation) {
        currentLocation = location
        getPlace(for: location) { [weak self] place in
            self?.handlePlace(place)
        }
    }
    
    private func handlePlace(_ place: CLPlacemark?) {
        guard let place = place else {
            delegate?.locationManagerDidFinishWithError(NSError(domain: "WetherApp", code: -10001))
            return
        }
        GlobalPublishers.currentLocation.send(place)
        delegate?.locationManagerDidFetchLocation(with: place.locality)
    }
    
    private func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}

//MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        if let location = locations.first {
            handleLocation(location)
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error.localizedDescription)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
            handleAuthorizationStatus(status)
    }
}
