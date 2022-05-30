//
//  Main.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import SwiftUI

struct Main: View {
    @StateObject private var viewModel: ViewModel
    
    @EnvironmentObject var userLocationService: UserLocationService
    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var weatherService: WeatherService
        
    var body: some View {
        NavigationView {
            ZStack {
                if weatherService.currentLocation != nil {
                    ScrollView(showsIndicators: false) {
                        
                        Text(LocalizedStringKey(weatherService.currentLocation?.name ?? "Weather"))
                            .textCase(.uppercase)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        
                        WeatherCard(currentWeather: weatherService.currentWeather, units: weatherService.units)
                        
                        LineDivider()

                        HourlyWeather(hourlyWeather: weatherService.hourlyWeather)
                        
                        LineDivider()
                        
                        DailyWeather(dailyWeather: weatherService.dailyWeather)
                        
                    }
                } else {
                    Text("add-city-text")
                }
                
                if weatherService.isLoading {
                    Color.white
                        .ignoresSafeArea()
                    
                    ProgressView()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showingCityList.toggle()
                        }
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }

                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            viewModel.showingSettings.toggle()
                        }
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
                
            }
            .onAppear {
                userLocationService.checkIfLocationServicesIsEnabled()
            }
            .onChange(of: userLocationService.lastKnownLocation) { _ in
                viewModel.getWeatherByLocationStatus(weatherService: weatherService, favorites: favorites, userLocationService: userLocationService)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .overlay(viewModel.showingCityList ? FavoriteCities(showingCityList: $viewModel.showingCityList) : nil)
        .overlay(viewModel.showingSettings ? Settings(showingSettings: $viewModel.showingSettings) : nil)
        .foregroundColor(Color("Dark"))
        .navigationViewStyle(.stack)
        .preferredColorScheme(.light)
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
            .environmentObject(UserLocationService())
    }
}
