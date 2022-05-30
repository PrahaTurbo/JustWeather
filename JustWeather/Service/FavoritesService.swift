//
//  FavoritesService.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import Foundation

@MainActor final class FavoritesService: ObservableObject {
    
    @Published var cities: [Location] {
        didSet {
            save()
        }
    }
        
    @Published var alertForAdd = false
    
    func favoriteCitiesWithUserLocation(location: Location?) -> [Location] {
        var result = cities
        if let location = location {
            result.insert(location, at: 0)
        }

        return result
    }
    
    func add(city: Location) {
        if city == .placeholder {
            alertForAdd = true
        } else {
            cities.append(city)
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(cities)
            try data.write(to: SaveKeys.favoriteCities.savePath, options: [.atomicWrite, .completeFileProtection])
            
            print("Saved favorite cities")
        } catch {
            print("Unable to save favorite cities")
        }
    }
    
    func delete(city: Location) {
        if let indexCity = cities.firstIndex(of: city) {
            cities.remove(at: indexCity)
        } else {
            print("Unable to delete \(city.name) from favorites")
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: SaveKeys.favoriteCities.savePath)
            cities = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            cities = []
        }
    }
}
