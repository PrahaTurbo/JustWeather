//
//  DailyWeather.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import SwiftUI

struct DailyWeather: View {
    let dailyWeather: [Weather.Daily]
    
    var body: some View {
        VStack {
            ForEach(dailyWeather.dropFirst(), id: \.self) { day in
                ZStack {
                    HStack {
                        Text(LocalizedStringKey(day.dt.formatted(.dateTime.weekday(.wide)).capitalizingFirstLetter()))
                        

                        Spacer()
                        
                        Text(day.temp.max.roundedDegrees())
                            .frame(width: 35, alignment: .trailing)
                            .font(.subheadline.bold())
                        
                        Text(day.temp.min.roundedDegrees())
                            .foregroundColor(.secondary)
                            .frame(width: 35, alignment: .trailing)
                    }
                    
                    Spacer()
                    
                    Image(systemName: day.weather[0].getWeatherIcon())
                        .font(.title)
                    
                    Spacer()
                    
                }
                .font(.subheadline)
                
            }
        }
        .padding(.horizontal)
    }
}

struct DailyWeather_Previews: PreviewProvider {
    static let collection: Weather = Bundle.main.decode("exampleWeather.json")
    
    static var previews: some View {
        DailyWeather(dailyWeather: collection.daily)
    }
}
