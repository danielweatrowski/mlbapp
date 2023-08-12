//
//  StandingsHeaderRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI

struct StandingsHeaderRowView: View {
    var body: some View {
        GridRow {
            Text("")
                .frame(width: 17, alignment: .leading)
            Text("")
                .frame(width: 46, alignment: .leading)
            Text("W")
            Text("L")
            Text("PCT")
            Text("GB")
            Text("L10")
            Text("STRK")
        }
        .bold()
        .font(.subheadline)
    }
}
