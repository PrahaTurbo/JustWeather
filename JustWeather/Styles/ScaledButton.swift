//
//  ScaledButton.swift
//  JustWeather
//
//  Created by Артем Ластович on 28.05.2022.
//

import Foundation
import SwiftUI

struct ScaledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
