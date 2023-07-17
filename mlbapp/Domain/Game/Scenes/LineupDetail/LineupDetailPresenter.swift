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
        
        guard let homeLineup = output.lineups.home else {
            return
        }
        
        // TODO: DRY
        let players: [LineupRowViewModel] = homeLineup
            .compactMap { player in
                guard let battingIndex = player.battingOrderIndex else {
                    return nil
                }
                return LineupRowViewModel(systemImageName: "\(battingIndex).circle.fill",
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
        
        let awayPlayers: [LineupRowViewModel] = awayLineup
            .compactMap { player in
                guard let battingIndex = player.battingOrderIndex else {
                    return nil
                }
                return LineupRowViewModel(systemImageName: "\(battingIndex).circle.fill",
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
