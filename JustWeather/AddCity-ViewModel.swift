//
//  AddCity-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 17.05.2022.
//

import Foundation
import CoreLocation

@MainActor final class ContentViewModel: ObservableObject {
    @Published var currentGeolocation = "nothing"
    
    
    func getCoordinate(addressString: String) async {
        
        do {
            print("start fetching")
            let placemarks = try await CLGeocoder().geocodeAddressString(addressString)
            print("end fetching")

            print("start saving")

            let coordinates = placemarks[0].location?.coordinate ?? CLLocationCoordinate2D(latitude: 20, longitude: 20)
            currentGeolocation = String(coordinates.longitude)
            print("end saving")

            print(currentGeolocation)
            print("Succesfully got coodinates for: \(addressString)")
        } catch {
            print("Unable to get coordinates for: \(addressString)")
        }
    }
}
