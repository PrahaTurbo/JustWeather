//
//  WeatherEndpoint.swift
//  JustWeather
//
//  Created by Артем Ластович on 12.05.2022.
//

import Foundation

enum WeatherEndpoint {
    case location, weather
}

extension WeatherEndpoint {
    var urlString: String {
        switch self {
        case .location:
            return "https://api.openweathermap.org/geo/1.0/direct"
        case .weather:
            return "https://api.openweathermap.org/data/2.5/onecall"
        }
    }
}
