//
//  FavoritesService.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import Foundation

@MainActor final class FavoritesService: ObservableObject {
    @Published var cities = [String]()
    
    func addToFavorites(city: String) {
        cities.append(city)
    }
}
