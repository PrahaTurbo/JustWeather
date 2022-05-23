//
//  RoundedDegrees.swift
//  JustWeather
//
//  Created by Артем Ластович on 23.05.2022.
//

import Foundation

extension Double {
    func roundedDegrees() -> String {
        String(format: "%.0f", self.rounded()) + "°"
    }
}
