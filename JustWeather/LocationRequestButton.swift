//
//  LocationRequestButton.swift
//  JustWeather
//
//  Created by Артем Ластович on 30.05.2022.
//

import SwiftUI

struct LocationRequestButton: View {
    let settingsOpener: () -> Void
    
    var body: some View {
        Button {
            settingsOpener()
        } label: {
            ZStack {
                Color.white
                
                VStack(alignment: .leading) {
                    Text("add-user-location-title")
                    
                    Text("add-user-location-subtitle")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                   
            }
            .aspectRatio(1, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .stroke(lineWidth: 2)
            )
        }
        .buttonStyle(ScaledButton())
    }
}

struct LocationRequestButton_Previews: PreviewProvider {
    static var previews: some View {
        LocationRequestButton(settingsOpener: {})
    }
}
