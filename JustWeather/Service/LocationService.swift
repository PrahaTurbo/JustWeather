//
//  LocationService.swift
//  JustWeather
//
//  Created by Артем Ластович on 17.05.2022.
//

import Foundation
import MapKit
import CoreLocation

@MainActor final class LocationService: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published private(set) var locationResults = [MKLocalSearchCompletion]()
    
    private var searchCompleter = MKLocalSearchCompleter()
    
    @Published var searchTerm = "" {
        didSet {
            searchCompleter.delegate = self
            searchCompleter.region = MKCoordinateRegion()
            searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
            
            getCities(searchText: searchTerm)
            
            if searchTerm.isEmpty {
                locationResults.removeAll()
            }
        }
    }
    
    func getCities(searchText: String) {
        searchCompleter.queryFragment = searchText
        locationResults = searchCompleter.results
    }
    
    func getCoordinates(for city: String, subtitle: String) async -> Location {
        do {
            let placemarks = try await CLGeocoder().geocodeAddressString(city)
            let coordinates = placemarks[0].location?.coordinate ?? CLLocationCoordinate2D(latitude: 20, longitude: 20)
            
            print("Succesfully got coodinates for: \(city)")
            
            return Location(name: city, subtitle: subtitle, latitude: String(coordinates.latitude), longitude: String(coordinates.longitude))
        } catch {
            print("Unable to get coordinates for: \(city)")
        }
        
        return Location.placeholder
    }
}
