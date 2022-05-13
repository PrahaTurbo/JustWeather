//
//  Geolocation.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation

struct Location: Codable {
    let name: String
    let localNames: [String: String]
    let lat, lon: Double
    let country, state: String
}

typealias Locations = [Location]

