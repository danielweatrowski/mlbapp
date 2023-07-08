//
//  StandingsRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI

struct StandingsRowViewModel: Hashable {
    let teamAbbreviation: String
    let wins: String
    let losses: String
    let winningPCT: String
    let gamesBehind: String
    let lastTenRecord: String
    let streak: String
}

struct StandingsRowView: View {
    
    let viewModel: StandingsRowViewModel
    
    var body: some View {
        GridRow {
            Text(viewModel.teamAbbreviation)
                .frame(width: 46, alignment: .leading)
                .bold()
            Text(viewModel.wins)
            Text(viewModel.losses)
            Text(viewModel.winningPCT)
            Text(viewModel.gamesBehind)
            Text(viewModel.lastTenRecord)
            Text(viewModel.streak)
        }
    }
}
