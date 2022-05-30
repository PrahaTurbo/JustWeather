//
//  WeatherEndpoint.swift
//  JustWeather
//
//  Created by Артем Ластович on 12.05.2022.
//

import Foundation

enum WeatherEndpoint {
    case weather
}

extension WeatherEndpoint {
    var urlString: String {
        switch self {
        case .weather:
            return "https://api.openweathermap.org/data/2.5/onecall"
        }
    }
}
