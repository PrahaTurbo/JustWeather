//
//  FavoriteCities-ViewModel.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

extension FavoriteCities {
    @MainActor class ViewModel: ObservableObject {
        @Published var searchIsActive = false
        
        @Published var isEditing = false

    }
}
