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
//    @StateObject var locationService: LocationService

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(favorites)
//                .environmentObject(locationService)
        }
    }
    
    init() {
        _favorites = StateObject(wrappedValue: FavoritesService())
//        _locationService = StateObject(wrappedValue: LocationService())
    }
}
