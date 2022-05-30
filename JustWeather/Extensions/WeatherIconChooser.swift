//
//  IconService.swift
//  JustWeather
//
//  Created by Артем Ластович on 13.05.2022.
//

import Foundation
import SwiftUI

extension Weather.WeatherInfo {
    enum Icon: String {
        case thunderstorm = "cloud.bolt"
        case drizzle = "cloud.drizzle"
        case rain = "cloud.rain"
        case snow = "cloud.snow"
        case clearDay = "sun.max"
        case clearNight = "moon.stars"
        case cloudsDay = "cloud.sun"
        case cloudsNight = "cloud.moon"
        case fog = "cloud.fog"
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
            if self.icon.dropFirst(2) == "d" {
                return Icon.clearDay.rawValue
            } else {
                return Icon.clearNight.rawValue
            }
        case "Clouds":
            if self.icon.dropFirst(2) == "d" {
                return Icon.cloudsDay.rawValue
            } else {
                return Icon.cloudsNight.rawValue
            }
        default:
            return Icon.fog.rawValue
        }
    }
}
