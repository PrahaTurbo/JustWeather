//
//  Geolocation.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation

struct Location: Codable, Identifiable, Hashable {
    var id = UUID()
    let name: String
    let subtitle: String
    let latitude, longitude: String
    var temp = "0"
    
    static let placeholder = Location(name: "Moscow", subtitle: "Russia", latitude: "55.7615902", longitude: "37.60946")
}

//struct Location: Codable {
//    let name: String
//    let localNames: [String: String]
//    let lat, lon: Double
//    let country, state: String
//}
//
//typealias Locations = [Location]

