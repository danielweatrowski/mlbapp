//
//  RosterDetailPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

protocol RosterDetailPresentationLogic: SceneErrorPresentable {
    func presentRoster(output: RosterDetail.Output)
}

struct RosterDetailPresenter: RosterDetailPresentationLogic {
    
    let viewModel: RosterDetail.ViewModel
    
    func presentRoster(output: RosterDetail.Output) {
        let homeRosterViewModel = output.homeRoster.players.map { player in
            return RosterRowViewModel(playerNumberText: player.jerseyNumber,
                                      playerNameText: player.fullName,
                                      playerPositionText: player.position?.abbreviation ?? "-",
                                      playerInfoText: "")
        }
        let awayRosterViewModel = output.awayRoster.players.map { player in
            return RosterRowViewModel(playerNumberText: player.jerseyNumber,
                                      playerNameText: player.fullName,
                                      playerPositionText: player.position?.abbreviation ?? "-",
                                      playerInfoText: "")
        }
        
        DispatchQueue.main.async {
            viewModel.homeRoster = homeRosterViewModel
            viewModel.awayRoster = awayRosterViewModel
        }
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
}
