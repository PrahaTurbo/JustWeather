//
//  DailyWeather.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import SwiftUI

struct DailyWeather: View {
    @EnvironmentObject var weatherService: WeatherService
    
    var body: some View {
        VStack {
            ForEach(weatherService.dailyWeather.dropFirst(), id: \.self) { day in
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
}

struct DailyWeather_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeather()
    }
}
