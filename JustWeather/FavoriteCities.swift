//
//  FavoriteCities.swift
//  JustWeather
//
//  Created by Артем Ластович on 16.05.2022.
//

import SwiftUI
import MapKit

struct FavoriteCities: View {
    @StateObject private var viewModel: ViewModel
    
    @EnvironmentObject var favorites: FavoritesService
    @EnvironmentObject var weatherService: WeatherService
    @EnvironmentObject var userLocationService: UserLocationService
        
    @Binding var showingCityList: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        if let currentLocation = userLocationService.lastKnownLocation {
                            switch userLocationService.locationStatus {
                            case .authorizedAlways, .authorizedWhenInUse:
                                CityTile(showingCityList: $showingCityList, city: currentLocation, isEditing: false)
                            default:
                                LocationRequestButton {
                                    viewModel.settingsOpener()
                                }
                            }
                        }
                        
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
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(lineWidth: 2)
                            )
                        }
                        .buttonStyle(ScaledButton())
                    }
                    .shadow(color: .black.opacity(0.1), radius: 10)
                    .padding()
                }
                
                
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
                    Button(viewModel.isEditing ? "done-button" : "edit-button") {
                        withAnimation(.spring().speed(3)) {
                            viewModel.isEditing.toggle()
                        }
                    }
                    .foregroundColor(.accentColor)
                    .animation(nil, value: viewModel.isEditing)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("favorities-title")
                        .bold()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("alert-title", isPresented: $favorites.alertForAdd) {
                //There will be OK button by default
            } message: {
                Text("alert-message")
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
            .environmentObject(UserLocationService())
            .environmentObject(WeatherService())
    }
}
