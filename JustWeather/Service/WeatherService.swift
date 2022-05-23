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
    
    @Published var currentLocation = Location.placeholder
        
    private var exclude = "alerts,minutely"
    
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
            Task {
                await getWeather()
            }
            
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(units) {
                UserDefaults.standard.set(encoded, forKey: SaveKeys.units.rawValue)
            }
        }
    }
    private let apiKey = "391d04e8234958a46098aa97eed1c412"
    
    @Published var favoritiesTemp = [Location: Weather]()
    
    func getCurrentTemp(for locations: [Location]) async {
        for location in locations {
            let url = formUrl(for: location)
            
            do {
                let result: Weather = try await APIService.shared.fetchData(url: url)
                
                print("Weather fetched successfully for: \(location.name)")
                
                favoritiesTemp[location] = result
            } catch {
                print("Error handled: \(error), location: \(location.name)")
            }
        }
    }
    
    func getWeather() async {
        let url = formUrl(for: currentLocation)
        
        do {
            let result: Weather = try await APIService.shared.fetchData(url: url)
            
            dailyWeather = result.daily
            hourlyWeather = result.hourly
            currentWeather = result.current
            
            print("Weather fetched successfully for current location: \(currentLocation.name)")
        } catch {
            print("Error handled: \(error), current location: \(currentLocation.name)")
        }
    }
          
    func formUrl(for location: Location) -> URL? {
        var components = URLComponents(string: WeatherEndpoint.weather.urlString)
        components?.queryItems = [
            URLQueryItem(name: "lat", value: location.latitude),
            URLQueryItem(name: "lon", value: location.longitude),
            URLQueryItem(name: "exclude", value: exclude),
            URLQueryItem(name: "lang", value: language),
            URLQueryItem(name: "units", value: units.rawValue),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        return components?.url
    }
    
    func setNewWeather(location: Location) {
        hourlyWeather = favoritiesTemp[location]?.hourly ?? []
        dailyWeather = favoritiesTemp[location]?.daily ?? []
        currentWeather = favoritiesTemp[location]?.current ?? Weather.currentWeatherPlaceholder
        currentLocation = location
    }
    
    init() {
        if let savedUnits = UserDefaults.standard.data(forKey: SaveKeys.units.rawValue) {
            if let decodedUnits = try? JSONDecoder().decode(Unit.self, from: savedUnits) {
                units = decodedUnits
                return
            }
        }
        
        units = .metric
    }
    
    //    func getLocation() async throws {
    //        let result: Locations = try await APIService.shared.fetchData(url: locationUrl)
    //        latitude = String(result[0].lat)
    //        longitude = String(result[0].lon)
    //
    //        print("Location fetched successfully")
    //    }
    
//    var weatherUrl: URL? {
//        var components = URLComponents(string: WeatherEndpoint.weather.urlString)
//        components?.queryItems = [
//            URLQueryItem(name: "lat", value: currentLocation.latitude),
//            URLQueryItem(name: "lon", value: currentLocation.longitude),
//            URLQueryItem(name: "exclude", value: exclude),
//            URLQueryItem(name: "lang", value: language),
//            URLQueryItem(name: "units", value: units),
//            URLQueryItem(name: "appid", value: apiKey)
//        ]
//
//        return components?.url
//    }
    
//    var locationUrl: URL? {
//        var components = URLComponents(string: WeatherEndpoint.location.urlString)
//        components?.queryItems = [
//            URLQueryItem(name: "q", value: cityName),
//            URLQueryItem(name: "appid", value: apiKey)
//        ]
//
//        return components?.url
//    }
}

enum Unit: String, CaseIterable, Codable {
    case metric = "metric"
    case imperial = "imperial"
}
