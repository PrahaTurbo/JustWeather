//
//  MainView.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import SwiftUI

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension Double {
    func roundedDegrees() -> String {
        String(format: "%.0f", self.rounded()) + "°"
    }
}

struct MainView: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject var favorites: FavoritesService
    
    @State private var showingCityList = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    
                    WeatherCard()
                        .padding(.horizontal)
                                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        
                        HStack {
                            ForEach(viewModel.hourlyWeather.dropLast(24), id: \.self) { weather in
                                VStack {
                                    Text(weather.dt.formatted(.dateTime.hour()))
                                        .font(.caption)
                                    
                                    Spacer ()
                                    
                                    Image(systemName: weather.weather[0].getWeatherIcon())
                                        .font(.largeTitle)
                                    
                                    Spacer ()
                                    
                                    Text(weather.temp.roundedDegrees())
                                        .font(.title2.bold())
                                }
                                .frame(height: 100)
                                .padding()

                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack {
                        ForEach(viewModel.dailyWeather.dropFirst(), id: \.self) { day in
                            HStack {
                                Text(day.dt.formatted(.dateTime.weekday(.wide)))

                                Spacer()
                                
                                Image(systemName: day.weather[0].getWeatherIcon())
                                    .font(.largeTitle)
                                
                                Spacer()
                                
                                Text(day.temp.max.roundedDegrees())
                                
                                Text(day.temp.min.roundedDegrees())
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .task {
                    await viewModel.getWeather()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation(.spring()) {
                                showingCityList.toggle()
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                }
                
                
            }
            .environmentObject(viewModel)
            .navigationBarTitleDisplayMode(.inline)
        }
        .overlay(showingCityList ? AddCity(showingCityList: $showingCityList) : nil)
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(FavoritesService())
    }
}
