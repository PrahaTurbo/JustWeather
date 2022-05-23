//
//  HourlyWeather.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import SwiftUI

struct HourlyWeather: View {
    @EnvironmentObject var weatherService: WeatherService
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                ForEach(weatherService.hourlyWeather.dropLast(24), id: \.self) { weather in
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
    }
}

struct HourlyWeather_Previews: PreviewProvider {
    static var previews: some View {
        HourlyWeather()
    }
}
