//
//  AddCity.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import SwiftUI

struct AddCity: View {
    @EnvironmentObject var favorites: FavoritesService
    
    var body: some View {
        NavigationView {
            Form {
                
            }
        }
    }
}

struct AddCity_Previews: PreviewProvider {
    static var previews: some View {
        AddCity()
            .environmentObject(FavoritesService())
    }
}
