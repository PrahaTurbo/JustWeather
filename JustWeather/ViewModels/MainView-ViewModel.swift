//
//  MainView-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation
import Combine

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var hourlyWeather = [Weather.Current]()
        @Published private(set) var dailyWeather = [Weather.Daily]()
        @Published private(set) var currentWeather = Weather.currentWeatherPlaceholder
        @Published var cityName = "moscow"
        
        private var latitude = ""
        private var longitude = ""
        private var exclude = "alerts,minutely"
        @Published var language = "ru"
        @Published var units = "metric"
        
        private let apiKey = "391d04e8234958a46098aa97eed1c412"
        
        
        func getLocation() async throws {
            let result: Locations = try await APIService.shared.fetchData(url: locationUrl)
            latitude = String(result[0].lat)
            longitude = String(result[0].lon)
            
            print("Location fetched successfully")
        }
        
        func getWeather() async {
            do {
                try await getLocation()
                let result: Weather = try await APIService.shared.fetchData(url: weatherUrl)
                
                dailyWeather = result.daily
                hourlyWeather = result.hourly
                currentWeather = result.current
                
                print("Weather fetched successfully")
            } catch {
                print("Error handled: \(error)")
            }
        }
                
        var weatherUrl: URL? {
            var components = URLComponents(string: WeatherEndpoint.weather.urlString)
            components?.queryItems = [
                URLQueryItem(name: "lat", value: latitude),
                URLQueryItem(name: "lon", value: longitude),
                URLQueryItem(name: "exclude", value: exclude),
                URLQueryItem(name: "lang", value: language),
                URLQueryItem(name: "units", value: units),
                URLQueryItem(name: "appid", value: apiKey)
            ]
            
            return components?.url
        }
        
        var locationUrl: URL? {
            var components = URLComponents(string: WeatherEndpoint.location.urlString)
            components?.queryItems = [
                URLQueryItem(name: "q", value: cityName),
                URLQueryItem(name: "appid", value: apiKey)
            ]
            
            return components?.url
        }
        
    }
}
