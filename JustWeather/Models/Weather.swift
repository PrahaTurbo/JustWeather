//
//  Weather.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//


import Foundation

struct Weather: Codable {
    let current: Current
    let hourly: [Current]
    let daily: [Daily]
    
    struct Current: Codable {
        let dt: Date
        let temp: Double
        let feelsLike: Double
        let pressure: Int
        let humidity: Int
        let dewPoint: Double
        let uvi: Double
        let clouds: Int
        let visibility: Int
        let windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [WeatherInfo]
    }
    
    struct Daily: Codable {
        let dt: Int
        let sunrise: Int
        let sunset: Int
        let moonrise: Int
        let moonset: Int
        let moonPhase: Double
        let temp: Temp
        let feelsLike: FeelsLike
        let pressure, humidity: Int
        let dewPoint, windSpeed: Double
        let windDeg: Int
        let windGust: Double
        let weather: [WeatherInfo]
        let clouds: Int
        let pop, uvi: Double
        let rain: Double?
        
        struct FeelsLike: Codable {
            let day, night, eve, morn: Double
        }
        
        struct Temp: Codable {
            let day, min, max, night: Double
            let eve, morn: Double
        }
    }
    
    struct WeatherInfo: Codable, Hashable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    static let currentWeatherPlaceholder = Current(dt: Date.now, temp: 0.0, feelsLike: 0.0, pressure: 0, humidity: 0, dewPoint: 0.0, uvi: 0.0, clouds: 0, visibility: 0, windSpeed: 0.0, windDeg: 0, windGust: 0.0, weather: [WeatherInfo(id: 0, main: "", description: "", icon: "")])
}
