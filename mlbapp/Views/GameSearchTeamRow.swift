//
//  GameSearchTeamRow.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import SwiftUI

struct GameSearchTeamRow: View {
    var mlbTeam: MLBTeam?
    var atHome: Bool

    var body: some View {
        HStack() {
            Text(atHome ? "Home" : "Away")
            Spacer()
            if let mlbTeam = mlbTeam {
                Image("\(mlbTeam)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
            }

            Text(mlbTeam?.name ?? "Any")
                .foregroundColor(.secondary)
        }
    }
}

struct GameSearchTeamRow_Previews: PreviewProvider {
    static var previews: some View {
        GameSearchTeamRow(atHome: true)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
