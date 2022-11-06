//
//  TeamRow.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import SwiftUI

struct TeamRow: View {
    var mlbTeam: MLBTeam

    var body: some View {
        HStack {
            Image("\(mlbTeam)")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(mlbTeam.name)
        }
    }
}

struct TeamRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TeamRow(mlbTeam: .dodgers)
            TeamRow(mlbTeam: .yankees)
            TeamRow(mlbTeam: .pirates)
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
