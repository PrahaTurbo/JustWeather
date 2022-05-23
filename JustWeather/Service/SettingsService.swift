//
//  SettingsService.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

@MainActor final class SettingsService: ObservableObject {
    enum Unit: String, CaseIterable {
        case metric = "metric"
        case imperial = "imperial"
    }
    
    @Published var units = Unit.metric {
        didSet {
            print(units.rawValue)
        }
    }
}
