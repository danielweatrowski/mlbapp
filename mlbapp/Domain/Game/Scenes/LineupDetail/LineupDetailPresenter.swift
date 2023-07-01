//
//  LineupDetailPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

protocol LineupDetailPresentationLogic: SceneErrorPresentable {
    func presentLineups(output: LineupDetail.Output)
}

struct LineupDetailPresenter: LineupDetailPresentationLogic {
    
    let viewModel: LineupDetail.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        viewModel.sceneError.errorTitle = sceneError.errorTitle
        viewModel.sceneError.errorDescription = sceneError.errorDescription
        
        DispatchQueue.main.async {
            self.viewModel.sceneError.present()
        }
    }
    
    func presentLineups(output: LineupDetail.Output) {
        
        guard let homeLineup = output.lineups.home else {
            return
        }
        
        // TODO: DRY
        let players = homeLineup
            .filter({$0.battingOrderIndex != nil})
            .map { player in
                let battingIndex = Int(player.battingOrderIndex ?? "0") ?? 0
                return LineupRowViewModel(playerBattingIndex: battingIndex / 100,
                                          playerNameText: player.fullName,
                                          playerPositionText: player.position.abbreviation ?? "-",
                                          playerInfoText: "")
            }
        
        
        DispatchQueue.main.async {
            viewModel.homeLineup = players
        }
        
        guard let awayLineup = output.lineups.away else {
            return
        }
        
        let awayPlayers = awayLineup
            .filter({$0.battingOrderIndex != nil})
            .map { player in
                let battingIndex = Int(player.battingOrderIndex ?? "0") ?? 0
                return LineupRowViewModel(playerBattingIndex: battingIndex / 100,
                                          playerNameText: player.fullName,
                                          playerPositionText: player.position.abbreviation ?? "-",
                                          playerInfoText: "")
            }
        
        
        DispatchQueue.main.async {
            viewModel.awayLineup = awayPlayers
            viewModel.state = .loaded
        }
    }
}
