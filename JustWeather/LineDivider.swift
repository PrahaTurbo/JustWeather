//
//  LineDivider.swift
//  JustWeather
//
//  Created by Артем Ластович on 30.05.2022.
//

import SwiftUI

struct LineDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color("Dark"))
            .frame(height: 2)
            .padding(.bottom, 5)
            .padding(.horizontal)
    }
}

struct LineDivider_Previews: PreviewProvider {
    static var previews: some View {
        LineDivider()
    }
}
