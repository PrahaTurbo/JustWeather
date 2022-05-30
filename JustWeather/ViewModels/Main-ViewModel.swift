//
//  Main-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import Foundation
import Combine

extension Main {
    @MainActor class ViewModel: ObservableObject {
        
        @Published var showingCityList = false
        @Published var showingSettings = false
        
        func getWeatherByLocationStatus(weatherService: WeatherService, favorites: FavoritesService, userLocationService: UserLocationService) {
            switch userLocationService.locationStatus {
            case .authorizedAlways, .authorizedWhenInUse:
                weatherService.currentLocation = userLocationService.lastKnownLocation
                
                Task {
                    await weatherService.getWeather(addToFavoritiesWeather: false, for: weatherService.currentLocation)
                    await weatherService.getWeatherForFavorites(for: favorites.favoriteCitiesWithUserLocation(location: userLocationService.lastKnownLocation))
                }
                
            default:
                Task {
                    await weatherService.getWeather(addToFavoritiesWeather: false, for: weatherService.currentLocation)
                    await weatherService.getWeatherForFavorites(for: favorites.cities)
                }
            }
            
            print("Location status: " + userLocationService.statusString)
        }
    }
}
