//
//  MainView.swift
//  JustWeather
//
//  Created by Артем Ластович on 10.05.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: viewModel.getWeatherIcon(for: viewModel.currentWeather.weather[0]))
                        .font(.system(size: 90))
                    
                    Text(String(format: "%.0f", viewModel.currentWeather.temp.rounded()) + "°")
                            .font(.system(size: 100))
                        
                    Text(viewModel.currentWeather.weather[0].description)
                    Text("Ощущается как \(String(format: "%.0f", viewModel.currentWeather.feelsLike.rounded()))" + "°")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
            }
            .padding()
            .task {
                await viewModel.getWeather()
            }
        }
    }
    
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
