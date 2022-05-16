//
//  JustWeatherApp.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import SwiftUI

@main
struct JustWeather: App {
    @StateObject var favorites: FavoritesService
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(favorites)
        }
    }
    
    init() {
        _favorites = StateObject(wrappedValue: FavoritesService())
    }
}
