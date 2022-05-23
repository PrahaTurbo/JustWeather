//
//  Settings.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var weatherService: WeatherService
    
    @Binding var showingSettings: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Section("Система измерений") {
                    Picker("Система измерений", selection: $weatherService.units) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue.capitalizingFirstLetter())
                        }
                    }
                    .padding(5)
                    .listRowInsets(EdgeInsets())
                    .pickerStyle(.segmented)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            showingSettings = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Настройки")
        }
        .transition(.move(edge: .trailing))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(showingSettings: .constant(true))
            .environmentObject(WeatherService())
    }
}
