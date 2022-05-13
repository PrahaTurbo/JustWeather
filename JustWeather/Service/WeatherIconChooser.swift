//
//  IconService.swift
//  JustWeather
//
//  Created by Артем Ластович on 13.05.2022.
//

import Foundation

extension Weather.WeatherInfo {
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
    
    func getWeatherIcon() -> String {
        switch self.main {
        case "Thunderstorm":
            return Icon.thunderstorm.rawValue
        case "Drizzle":
            return Icon.drizzle.rawValue
        case "Rain":
            return Icon.rain.rawValue
        case "Snow":
            return Icon.snow.rawValue
        case "Clear":
            if self.main.dropFirst(2) == "d" {
                return Icon.clearDay.rawValue
            } else {
                return Icon.clearNight.rawValue
            }
        case "Clouds":
            if self.main.dropFirst(2) == "d" {
                return Icon.cloudsDay.rawValue
            } else {
                return Icon.cloudsNight.rawValue
            }
        default:
            return Icon.fog.rawValue
        }
    }
}
