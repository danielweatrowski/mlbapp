//
//  LinescorePitcherView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import SwiftUI

struct GameDecisionsSectionView: View {
    
    var winnerViewModel: GameDetailPitcherViewModel
    var loserViewModel: GameDetailPitcherViewModel
    var saverViewModel: GameDetailPitcherViewModel?

    var body: some View {
        
        Section("Decisions") {
            DetailGamePitcherView(viewModel: winnerViewModel)
//                .listRowSeparator(.hidden)
            
            DetailGamePitcherView(viewModel: loserViewModel)
            
            if let saverViewModel = saverViewModel {
                DetailGamePitcherView(viewModel: saverViewModel)
            }
        }
    }
}
