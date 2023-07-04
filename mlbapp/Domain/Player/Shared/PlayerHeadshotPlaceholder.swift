//
//  PlayerHeadshotPlaceholder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import SwiftUI

struct PlayerHeadshotPlaceholder: View {
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .padding()
            .frame(width: 150, height: 200)
            .background(.tertiary)
            .cornerRadius(10)
    }
}

struct PlayerHeadshotPlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        PlayerHeadshotPlaceholder()
    }
}
