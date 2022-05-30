//
//  WeatherService.swift
//  JustWeather
//
//  Created by Артем Ластович on 18.05.2022.
//

import Foundation
import CoreLocation

@MainActor final class WeatherService: ObservableObject {
    @Published private(set) var hourlyWeather = [Weather.Current]()
    @Published private(set) var dailyWeather = [Weather.Daily]()
    @Published private(set) var currentWeather = Weather.currentWeatherPlaceholder
    
    @Published var favoritiesWeather = [Location: Weather]()
    @Published var currentLocation: Location? {
        didSet {
            if oldValue != currentLocation {
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(currentLocation) {
                    UserDefaults.standard.set(encoded, forKey: SaveKeys.currentLocation.rawValue)
                }
            }
        }
    }
    
    @Published var isLoading = true
    
    private let apiKey = "" // <- ADD API KEY HERE
    
    //check language on user's phone to set right language param in url
    private var localLanguage = Locale.preferredLanguages.first?.dropLast(3)
    private var language: String {
        if localLanguage == "ru" {
            return String(localLanguage ?? "ru")
        } else {
            return "en"
        }
    }
    
    @Published var units = Unit.metric {
        didSet {
            if oldValue != units {
                Task {
                    await getWeather(addToFavoritiesWeather: false, for: currentLocation)
                }
                
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(units) {
                    UserDefaults.standard.set(encoded, forKey: SaveKeys.units.rawValue)
                }
            }
        }
    }
    
    
    func getWeatherForFavorites(for locations: [Location]) async {
        for location in locations {
            
            //check if we already loaded that location in currentLocation
            if currentLocation == location {
                favoritiesWeather[location] = Weather(current: currentWeather, hourly: hourlyWeather, daily: dailyWeather)
                continue
            }
            
            let url = formUrl(for: location)
            
            do {
                let result: Weather = try await APIService.shared.fetchData(url: url)
                
                print("Weather fetched successfully for favorite city: \(location.name)")
                
                favoritiesWeather[location] = result
            } catch {
                print("Error handled: \(error), location: \(location.name)")
            }
        }
    }
    
    func getWeather(addToFavoritiesWeather: Bool, for location: Location?) async {
        defer { isLoading = false }
        
        guard let location = location else { return }
        
        let url = formUrl(for: location)
        
        do {
            let result: Weather = try await APIService.shared.fetchData(url: url)
            
            //check if whether result needs to be in favoritesWeather
            if addToFavoritiesWeather {
                favoritiesWeather[location] = result
                
                print("Weather fetched for provided location: \(location.name)")
            } else {
                dailyWeather = result.daily
                hourlyWeather = result.hourly
                currentWeather = result.current
                
                print("Weather fetched for current location: \(location.name)")
            }
            
        } catch {
            print("Error handled: \(error), current location: \(location.name)")
        }
    }
    
    
    private func formUrl(for location: Location) -> URL? {
        var components = URLComponents(string: WeatherEndpoint.weather.urlString)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: location.latitude),
            URLQueryItem(name: "lon", value: location.longitude),
            URLQueryItem(name: "exclude", value: "alerts,minutely"),
            URLQueryItem(name: "lang", value: language),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        return components?.url
    }
    
    //set weather for main screen when user taps on favorite location
    func setNewWeather(location: Location) {
        hourlyWeather = favoritiesWeather[location]?.hourly ?? []
        dailyWeather = favoritiesWeather[location]?.daily ?? []
        currentWeather = favoritiesWeather[location]?.current ?? Weather.currentWeatherPlaceholder
        currentLocation = location
    }
    
    init() {
        if let savedUnits = UserDefaults.standard.data(forKey: SaveKeys.units.rawValue) {
            if let decodedUnits = try? JSONDecoder().decode(Unit.self, from: savedUnits) {
                units = decodedUnits
            }
        } else {
            units = .metric
        }
        
        
        if let savedCurrentLocation = UserDefaults.standard.data(forKey: SaveKeys.currentLocation.rawValue) {
            if let decodedCurrentLocation = try? JSONDecoder().decode(Location.self, from: savedCurrentLocation) {
                currentLocation = decodedCurrentLocation
            }
        }
    }
    
}

enum Unit: String, CaseIterable, Codable {
    case metric = "metric"
    case imperial = "imperial"
}
