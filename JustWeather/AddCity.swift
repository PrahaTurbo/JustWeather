//
//  AddCity.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import SwiftUI
import MapKit

struct AddCity: View {
    @EnvironmentObject var favorites: FavoritesService
    //    @EnvironmentObject var locationService: LocationService
    
    @StateObject var viewModel: ContentViewModel
    @StateObject private var mapSearch = MapSearch()
    
    @Binding var showingCityList: Bool
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                TextField("Search", text: $mapSearch.searchTerm)
                
                VStack {
                    ForEach(mapSearch.locationResults, id: \.self) { location in
                        Button {
                            Task {
                                await viewModel.getCoordinate(addressString: location.title)
                            }
                        } label: {
                            VStack(alignment: .leading) {
                                Text(location.title)
                                Text(location.subtitle)
                                    .font(.system(.caption))
                            }
                        }
                    }
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring()) {
                            showingCityList = false
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
        .transition(.move(edge: .leading))
        
    }
    
    init(showingCityList: Binding<Bool>) {
        _showingCityList = showingCityList
        _viewModel = StateObject(wrappedValue: ContentViewModel())
    }
}

struct AddCity_Previews: PreviewProvider {
    static var previews: some View {
        AddCity(showingCityList: .constant(true))
            .environmentObject(FavoritesService())
        //            .environmentObject(LocationService())
    }
}
