//
//  CityTile.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import SwiftUI

struct CityTile: View {
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var favorites: FavoritesService
    
    @Binding var showingCityList: Bool
    let city: Location
    let isEditing: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Button {
                weatherService.setNewWeather(location: city)
                
                withAnimation(.spring()) {
                    showingCityList = false
                }
            } label: {
                ZStack(alignment: .top) {
                    Color.white

                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text(weatherService.favoritiesTemp[city]?.current.temp.roundedDegrees() ?? "0")
                                .font(.largeTitle.bold())
                            
                            Spacer()
                            
                            Image(systemName: weatherService.favoritiesTemp[city]?.current.weather[0].getWeatherIcon() ?? "cloud")
                                .font(.largeTitle)
                                .imageScale(.large)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(city.name)
                        
                            Text(city.subtitle)
                                .foregroundColor(.secondary)
                        }
                        
                        HStack {
                            Label("\(weatherService.favoritiesTemp[city]?.current.humidity ?? 0)%", systemImage: "humidity.fill")
                            
                            Spacer()
                            
                            Label("\(String(weatherService.favoritiesTemp[city]?.current.windSpeed ?? 0)) \(weatherService.units == .metric ? "м/с" : "mph")", systemImage: "wind")
                        }
                        .font(.caption)

                    }
                    .padding()
                }
                .aspectRatio(1, contentMode: .fit)
                .foregroundColor(.primary)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .zIndex(1)
            
            if isEditing {
                Image(systemName: "minus.circle.fill")
                    .offset(x: -5, y: -5)
                    .font(.title2)
                    .symbolRenderingMode(.multicolor)
                    .transition(.scale.combined(with: .opacity))
                    .zIndex(2)
                    .onTapGesture {
                        favorites.delete(city: city)
                    }
            }
        }
    }
}

struct CityTile_Previews: PreviewProvider {
    static var previews: some View {
        CityTile(showingCityList: .constant(false), city: .placeholder, isEditing: true)
            .environmentObject(WeatherService())
            .environmentObject(FavoritesService())
            .padding()
            .shadow(radius: 10)
    }
}
