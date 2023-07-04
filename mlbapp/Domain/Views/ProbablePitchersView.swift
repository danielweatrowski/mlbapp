//
//  ProbablePitchersView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import SwiftUI

struct ProbablePitchersViewModel {
    let homeTeamName: String
    let homeTeamProbablePitcher: String? // todo: make optional
    let awayTeamName: String
    let awayTeamProbablePitcher: String? // todo: make optional
}

struct ProbablePitchersView: View {
    
    let viewModel: ProbablePitchersViewModel?
    
    var body: some View {
        if let viewModel = viewModel {
            VStack {
                DetailGamePitcherView(titleText: "Home",
                                  pitcherNameText: viewModel.homeTeamProbablePitcher ?? "TBD",
                                  pitcherInfoText:  "")
                Divider()
                
                DetailGamePitcherView(titleText: "Away",
                                  pitcherNameText: viewModel.awayTeamProbablePitcher ?? "TBD",
                                  pitcherInfoText:  "")
            }
        } else {
            // TODO: Handle empty state
            EmptyView()
        }
    }
    

}

struct ProbablePitchersView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
