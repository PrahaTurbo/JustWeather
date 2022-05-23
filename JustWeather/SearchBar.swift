//
//  SearchBar.swift
//  JustWeather
//
//  Created by Артем Ластович on 20.05.2022.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @FocusState var searchIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    Rectangle()
                        .fill(Color("LightGray"))
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search-placeholder", text: $searchText)
                            .focused($searchIsFocused)
                            .submitLabel(.search)
                        
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                            }
                            .padding(.trailing, 13)
                        }
                    }
                    .padding(.leading, 13)
                    .foregroundColor(.secondary)
                }
                .cornerRadius(13)
            }
            .frame(height: 40)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                searchIsFocused = true
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = ""
    
    static var previews: some View {
        SearchBar(searchText: $text)
    }
}
