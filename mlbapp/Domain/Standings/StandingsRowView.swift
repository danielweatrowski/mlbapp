//
//  StandingsRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI

struct StandingsRowViewModel: Hashable {
    let teamRank: Int
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

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
