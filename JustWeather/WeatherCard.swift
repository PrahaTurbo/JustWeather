//
//  WeatherCard.swift
//  JustWeather
//
//  Created by Артем Ластович on 13.05.2022.
//

import SwiftUI

struct WeatherCard: View {
    @EnvironmentObject var viewModel: MainView.ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                HStack(alignment: .top) {
                    Text(viewModel.currentWeather.temp.roundedDegrees().dropLast())
                        .font(.system(size: 100).bold())
                    
                    Text("°")
                        .font(.system(size: 50))
                }
                
                
                Spacer()
                
                Image(systemName: viewModel.currentWeather.weather[0].getWeatherIcon())
                    .font(.system(size: 100))
                
            }
            
            VStack(alignment: .leading) {
                
                Text(viewModel.currentWeather.weather[0].description.capitalizingFirstLetter())
                    .font(.headline)

                
                Text("Ощущается как \(viewModel.currentWeather.feelsLike.roundedDegrees())")
                    .font(.subheadline)
            }
            
            HStack {
                Label("\(viewModel.currentWeather.humidity)%", systemImage: "humidity.fill")
                
                Spacer()
                
                Label("\(String(viewModel.currentWeather.windSpeed)) м/с", systemImage: "wind")
                
                Spacer()
                
                Label("\(viewModel.currentWeather.visibility / 1000) км", systemImage: "eye.fill")
            }
            .padding(.top, 30)
        }
        .padding()
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
