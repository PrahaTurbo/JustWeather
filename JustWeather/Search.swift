//
//  Search.swift
//  JustWeather
//
//  Created by Артем Ластович on 20.05.2022.
//

import SwiftUI

struct Search: View {
    @EnvironmentObject var locationService: LocationService
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var favorites: FavoritesService
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    SearchBar(searchText: $locationService.searchTerm)
                    
                    Button("Отменить") {
                        locationService.searchTerm.removeAll()
                        
                        dismiss()
                    }
                }
                
                ForEach(locationService.locationResults, id: \.self) { location in
                    Button {
                        Task {
                            favorites.add(city: await locationService.getCoordinates(for: location.title, subtitle: location.subtitle))
                            
                            await weatherService.getCurrentTemp(for: favorites.cities)
                            
                            locationService.searchTerm.removeAll()
                        }
                        
                        dismiss()
                    } label: {
                        VStack(alignment: .leading) {
                            Text(location.title)
                            Text(location.subtitle)
                                .font(.system(.caption))
                        }
                    }
                    .foregroundColor(.primary)
                }
                .padding(.horizontal)
            }
            .padding()
        }
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
            .environmentObject(LocationService())
            .environmentObject(WeatherService())
            .environmentObject(FavoritesService())
    }
}
