//
//  TeamList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import SwiftUI

struct TeamList: View {
    var body: some View {
        NavigationView {
            List(MLBTeam.allCases) { team in
                TeamRow(mlbTeam: team)
            }
            .navigationTitle("MLB Teams")
        }
    }
}

struct TeamList_Previews: PreviewProvider {
    static var previews: some View {
        TeamList()
    }
}
