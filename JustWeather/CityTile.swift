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
    @EnvironmentObject var userLocationService: UserLocationService
    
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
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(weatherService.favoritiesWeather[city]?.current.temp.roundedDegrees() ?? "--")
                                .font(.largeTitle.bold())
                            
                            Spacer()
                            
                            Image(systemName: weatherService.favoritiesWeather[city]?.current.weather[0].getWeatherIcon() ?? "cloud")
                                .font(.largeTitle)
                                .shadow(color: .black.opacity(0.1), radius: 10)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 3) {
                                if city.name == "current-location-name" {
                                    Image(systemName: "location.fill")
                                        .font(.caption)
                                }
                                
                                Text(LocalizedStringKey(city.name))
                                    .minimumScaleFactor(0.5)
                            }
                            
                            Text(city.subtitle)
                                .foregroundColor(.secondary)
                                .font(.caption)
                                .minimumScaleFactor(0.5)
                                .lineLimit(2)

                        }
                        
                        Spacer()
                        
                        HStack {
                            Label("\(weatherService.favoritiesWeather[city]?.current.humidity ?? 0)%", systemImage: "humidity.fill")
                            
                            Spacer()
                            
                            Label("\(String(weatherService.favoritiesWeather[city]?.current.windSpeed ?? 0)) \(weatherService.units == .metric ? "м/с" : "mph")", systemImage: "wind")
                        }
                        .font(.caption)
                        .minimumScaleFactor(0.5)

                    }
                    .padding()
                }
                .aspectRatio(1, contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .stroke(lineWidth: 2)
                )
                .overlay(isEditing
                         ? Button {
                            favorites.delete(city: city)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .offset(x: -5, y: -5)
                                .font(.title2)
                                .symbolRenderingMode(.multicolor)
                        }
                        .buttonStyle(ScaledButton())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                         : nil
                )
            }
            .buttonStyle(ScaledButton())
        }
    }
}

struct CityTile_Previews: PreviewProvider {
    static var previews: some View {
        CityTile(showingCityList: .constant(false), city: .placeholder, isEditing: true)
            .environmentObject(WeatherService())
            .environmentObject(FavoritesService())
            .environmentObject(UserLocationService())
            .padding()
            .shadow(radius: 10)
    }
}
