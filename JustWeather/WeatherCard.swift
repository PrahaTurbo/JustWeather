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
                        .font(.system(size: 100, design: .rounded).bold())
                    
                    Text("°")
                        .font(.system(size: 50))
                }
                
                
                Spacer()
                
                Image(systemName: viewModel.currentWeather.weather[0].getWeatherIcon())
                    .font(.system(size: 100))
                    .border(.red)
                
            }
            
            VStack(alignment: .leading) {
                
                Text(viewModel.currentWeather.weather[0].description.capitalizingFirstLetter())
                    .font(.system(.headline, design: .rounded))

                
                Text("Ощущается как \(viewModel.currentWeather.feelsLike.roundedDegrees())")
                    .font(.system(.subheadline, design: .rounded))
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
        .background(.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct WeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
