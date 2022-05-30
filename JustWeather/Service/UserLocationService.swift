//
//  GeolocationService.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import CoreLocation
import Foundation

final class UserLocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var manager: CLLocationManager?
    @Published private(set) var locationStatus: CLAuthorizationStatus?
    @Published private(set) var lastKnownLocation: Location?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            manager = CLLocationManager()
            manager?.delegate = self
        } else {
            print("You need to turn on Location Services in settings")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let manager = manager else { return }
        
        locationStatus = manager.authorizationStatus
        
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            lastKnownLocation = .placeholder
            print("Location is restricted likely due parental controls")
        case .denied:
            lastKnownLocation = .placeholder
            print("User has denied this app location permission")
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startMonitoringSignificantLocationChanges()
        @unknown default:
            break
        }
        
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        lastKnownLocation = Location(name: "current-location-name", subtitle: " ", latitude: String(location.coordinate.latitude), longitude: String(location.coordinate.longitude))
        
        print(lastKnownLocation ?? "")
    }
    
    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }
        
        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }
    }
}

