//
//  ProbablePitchersSectionView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import SwiftUI

// TODO: REDO
struct ProbablePitchersSectionView: View {
    
    let home: GameDetailPitcherViewModel?
    let away: GameDetailPitcherViewModel?
    
    var body: some View {
        
        Section("Probable Pitchers") {
            if let homeVM = home {
                DetailGamePitcherView(viewModel: homeVM)
            } else {
                // TODO: SHOW NO DATA
            }
            
            if let awayVM = away  {
                DetailGamePitcherView(viewModel: awayVM)
            } else {
                // TODO: SHOW NO DATA
            }
        }
        
    }
}
