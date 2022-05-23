//
//  CapitalizingFirstLetter.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
