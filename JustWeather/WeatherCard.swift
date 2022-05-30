//
//  WeatherCard.swift
//  JustWeather
//
//  Created by Артем Ластович on 13.05.2022.
//

import SwiftUI

struct WeatherCard: View {
    let currentWeather: Weather.Current
    let units: Unit
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                HStack(alignment: .top) {
                    Text(currentWeather.temp.roundedDegrees().dropLast())
                        .font(.system(size: 100).bold())
                    
                    Text("°")
                        .font(.system(size: 50))
                }
                
                
                Spacer()
                
                Image(systemName: currentWeather.weather[0].getWeatherIcon())
                    .font(.system(size: 100))
            }
            
            VStack(alignment: .leading) {
                
                Text(currentWeather.weather[0].description.capitalizingFirstLetter())
                    .font(.headline)

                
                Text("feels-like")
                    .font(.caption)
                    .foregroundColor(.secondary)
                + Text(" \(currentWeather.feelsLike.roundedDegrees())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            HStack {
                Label("\(currentWeather.humidity)%", systemImage: "humidity.fill")
                
                Spacer()
                
                HStack(spacing: 3) {
                    Label("\(String(currentWeather.windSpeed))", systemImage: "wind")
                    
                    Text(units == .metric ? "metre-per-second" : "mph")
                }
                
                Spacer()
                
                HStack(spacing: 3) {
                    Label("\(currentWeather.visibility / 1000)", systemImage: "eye.fill")
                    
                    Text("kilometers")

                }
            }
            .font(.subheadline)
            .padding(.top, 30)
        }
        .padding(.horizontal)
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static let collection: Weather = Bundle.main.decode("exampleWeather.json")
    
    static var previews: some View {
        WeatherCard(currentWeather: collection.current, units: .metric)
    }
}
