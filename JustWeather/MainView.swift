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
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                
                WeatherCard()
                
                Spacer()
            }
            .padding()
            .task {
                await viewModel.getWeather()
            }
        }
        .environmentObject(viewModel)
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
