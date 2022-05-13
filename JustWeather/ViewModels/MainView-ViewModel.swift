//
//  MainView-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation
import Combine

enum Icon: String {
    case thunderstorm = "cloud.bolt.fill"
    case drizzle = "cloud.drizzle.fill"
    case rain = "cloud.rain.fill"
    case snow = "cloud.snow.fill"
    case clearDay = "sun.max.fill"
    case clearNight = "moon.stars.fill"
    case cloudsDay = "cloud.sun.fill"
    case cloudsNight = "cloud.moon.fill"
    case fog = "cloud.fog.fill"
}

extension MainView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var hourlyWeather = [Weather.Current]()
        @Published private(set) var dailyWeather = [Weather.Daily]()
        @Published private(set) var currentWeather = Weather.currentWeatherPlaceholder
        @Published var cityName = "moscow"
        
        func getWeatherIcon(for weather: Weather.WeatherInfo) -> String {
            switch weather.main {
            case "Thunderstorm":
                return Icon.thunderstorm.rawValue
            case "Drizzle":
                return Icon.drizzle.rawValue
            case "Rain":
                return Icon.rain.rawValue
            case "Snow":
                return Icon.snow.rawValue
            case "Clear":
                if weather.icon.dropFirst(2) == "d" {
                    return Icon.clearDay.rawValue
                } else {
                    return Icon.clearNight.rawValue
                }
            case "Clouds":
                if weather.icon.dropFirst(2) == "d" {
                    return Icon.cloudsDay.rawValue
                } else {
                    return Icon.cloudsNight.rawValue
                }
            default:
                return Icon.fog.rawValue
            }
        }
        
        private var latitude = ""
        private var longitude = ""
        private var exclude = "alerts,minutely"
        @Published var language = "ru"
        @Published var units = "metric"
        
        private let apiKey = "391d04e8234958a46098aa97eed1c412"
        
        
        func getLocation() async {
            do {
                let result: Locations = try await APIService.shared.fetchData(url: locationUrl)
                
                latitude = String(result[0].lat)
                longitude = String(result[0].lon)
            } catch {
                print("Error handled: \(error)")
            }
        }
        
        func getWeather() async {
            do {
                await getLocation()
                let result: Weather = try await APIService.shared.fetchData(url: weatherUrl)
                
                dailyWeather = result.daily
                hourlyWeather = result.hourly
                currentWeather = result.current
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
