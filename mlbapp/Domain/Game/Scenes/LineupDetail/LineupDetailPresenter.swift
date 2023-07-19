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
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    func presentLineups(output: LineupDetail.Output) {
        
        DispatchQueue.main.async {
            viewModel.homeLineup = formatLineup(players: output.lineups.home)
            viewModel.awayLineup = formatLineup(players: output.lineups.away)
            viewModel.state = .loaded
        }
    }
    
    func formatLineup(players: [Boxscore_V2.Player]?) -> [LineupRowViewModel] {
        guard let lineupPlayers = players else {
            return []
        }
        
        let lineupRows: [LineupRowViewModel] = lineupPlayers
            .compactMap { player in
                guard let battingIndex = player.battingOrderIndex else {
                    return nil
                }
                return LineupRowViewModel(systemImageName: "\(battingIndex).circle.fill",
                                          playerNameText: player.fullName,
                                          playerPositionText: player.position.abbreviation ?? "-",
                                          playerInfoText: "")
            }
        
        return lineupRows
    }
}
