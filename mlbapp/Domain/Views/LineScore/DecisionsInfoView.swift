//
//  LinescorePitcherView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import SwiftUI

struct DecisionsInfoView: View {
    
    @Binding var viewModel: DecisionsInfoViewModel?

    var body: some View {
        if let viewModel = viewModel {
            VStack {
                DetailGamePitcherView(titleText: "Win",
                                  pitcherNameText: viewModel.winningPitcherName,
                                  pitcherInfoText:  "\(viewModel.winningPitcherWins) - \(viewModel.winningPitcherLosses) | \(viewModel.winningPitcherERA)")
                Divider()
                
                DetailGamePitcherView(titleText: "Loss",
                                  pitcherNameText: viewModel.losingPitcherName,
                                  pitcherInfoText:  "\(viewModel.losingPitcherWins) - \(viewModel.losingPitcherLosses) | \(viewModel.losingPitcherERA) ERA")
                
                if let savePitcher = viewModel.savingPitcherName {
                    Divider()
                    DetailGamePitcherView(titleText: "Save",
                                      pitcherNameText: savePitcher,
                                      pitcherInfoText:  "\(viewModel.savingPitcherWins) - \(viewModel.savingPitcherLosses) | \(viewModel.savingPitcherERA) ERA")

                }
            }
            .padding()
        } else {
            EmptyView()
        }
    }
}

struct LinescorePitcherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionsInfoView(viewModel: .constant(nil))
    }
}
