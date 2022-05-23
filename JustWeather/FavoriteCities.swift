//
//  FavoriteCities.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import SwiftUI
import MapKit

struct FavoriteCities: View {
    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var locationService: LocationService
    @EnvironmentObject var weatherService: WeatherService
    
    @StateObject private var viewModel: ViewModel
    
    @Binding var showingCityList: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(favorites.cities) { city in
                        CityTile(showingCityList: $showingCityList, city: city, isEditing: viewModel.isEditing)
                    }
                    
                    Button {
                        viewModel.searchIsActive = true
                    } label: {
                        ZStack {
                            Color.white
                            
                            Image(systemName: "plus")
                                .font(.largeTitle)
                                .imageScale(.large)
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                }
                .shadow(color: .black.opacity(0.1), radius: 10)
                .padding()
            }
            .sheet(isPresented: $viewModel.searchIsActive) {
                Search()
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
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.isEditing ? "Готово" : "Изменить") {
                        withAnimation(.spring().speed(3)) {
                            viewModel.isEditing.toggle()
                        }
                    }
                    .animation(nil, value: viewModel.isEditing)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .task {
                await weatherService.getCurrentTemp(for: favorites.cities)
            }
            .alert("Ошибка добавления", isPresented: $favorites.alertForAdd) {
                //
            } message: {
                Text("Не получилось добавить локацию. Попробуйте выбрать другую.")
            }

        }
        .transition(.move(edge: .leading))
    }
    
    init(showingCityList: Binding<Bool>) {
        _showingCityList = showingCityList
        
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
}

struct FavoriteCities_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCities(showingCityList: .constant(true))
            .environmentObject(FavoritesService())
            .environmentObject(LocationService())
            .environmentObject(WeatherService())

    }
}
