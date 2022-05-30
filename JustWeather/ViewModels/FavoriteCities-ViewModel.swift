//
//  FavoriteCities-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation
import SwiftUI

extension FavoriteCities {
    @MainActor class ViewModel: ObservableObject {
        @Published var searchIsActive = false
        
        @Published var isEditing = false
        
        func settingsOpener() {
            if let url = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
