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
    @StateObject var locationService: LocationService
    @StateObject var weatherService: WeatherService
    @StateObject var settingsService: SettingsService

    
    var body: some Scene {
        WindowGroup {
            Main()
                .environmentObject(favorites)
                .environmentObject(locationService)
                .environmentObject(weatherService)
                .environmentObject(settingsService)

        }
    }
    
    init() {
        _favorites = StateObject(wrappedValue: FavoritesService())
        _locationService = StateObject(wrappedValue: LocationService())
        _weatherService = StateObject(wrappedValue: WeatherService())
        _settingsService = StateObject(wrappedValue: SettingsService())
    }
}
