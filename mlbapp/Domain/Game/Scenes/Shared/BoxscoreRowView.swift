//
//  BoxscoreRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import SwiftUI

struct BoxscoreRowView: View {
    
    var columns: [GridItem] = [
        GridItem(.fixed(120)),
        GridItem(.flexible()),
        GridItem(.fixed(16)),
        GridItem(.fixed(16)),
        GridItem(.fixed(16)),
        GridItem(.fixed(16)),
        GridItem(.fixed(16)),
        GridItem(.fixed(16)),
        GridItem(.fixed(28)),
        GridItem(.fixed(28)),
    ]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            nameField
            Spacer()
            Text("5")
                .font(.subheadline)
            Text("5")
                .font(.subheadline)

            Text("5")
                .font(.subheadline)

            Text("5")
                .font(.subheadline)

            Text("5")
                .font(.subheadline)

            Text("5")
                .font(.subheadline)

            Text("5")
                .font(.subheadline)

            Text(".555")
                .font(.subheadline)

        }
    }
    
    @ViewBuilder
    var nameField: some View {
        Text("Weatrowski")
            .bold()
        + Text("  RF")
            .font(.footnote)
            .foregroundColor(.secondary)
    }
}

struct BoxscoreRowView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreRowView()
    }
}
