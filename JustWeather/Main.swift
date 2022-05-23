//
//  Main.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import SwiftUI

struct Main: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var weatherService: WeatherService
        
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    
                    WeatherCard()
                        .padding(.horizontal)
                                    
                    HourlyWeather()
                    
                    DailyWeather()
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            viewModel.showingCityList.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.spring()) {
                            viewModel.showingSettings.toggle()
                        }
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .task {
                await weatherService.getWeather()
                await weatherService.getCurrentTemp(for: favorites.cities)
            }
            .navigationTitle(weatherService.currentLocation.name)
            .navigationBarTitleDisplayMode(.inline)
        }
        .overlay(viewModel.showingCityList ? FavoriteCities(showingCityList: $viewModel.showingCityList) : nil)
        .overlay(viewModel.showingSettings ? Settings(showingSettings: $viewModel.showingSettings) : nil)
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
            .environmentObject(FavoritesService())
            .environmentObject(WeatherService())
    }
}
