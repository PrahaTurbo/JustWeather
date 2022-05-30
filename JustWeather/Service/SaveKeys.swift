//
//  SaveKeys.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

enum SaveKeys: String {
    case favoriteCities = "FavoriteCities"
    case units = "Units"
    case currentLocation = "CurrentLocation"
    
    var savePath: URL {
        FileManager.documentsDirectory.appendingPathComponent(self.rawValue)
    }
}
