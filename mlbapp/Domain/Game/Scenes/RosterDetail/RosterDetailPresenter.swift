//
//  RosterDetailPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation
import Common
import Models

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
                                      playerInfoText: "",
                                      details: formatDetails(player))
        }
        let awayRosterViewModel = output.awayRoster.players.map { player in
            return RosterRowViewModel(playerNumberText: player.jerseyNumber,
                                      playerNameText: player.fullName,
                                      playerPositionText: player.position?.abbreviation ?? "-",
                                      playerInfoText: "",
                                      details: formatDetails(player))
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
    
    private func formatDetails(_ player: Roster.Player) -> [RosterRowViewModel.DetailItem] {
        let throwsDetail = RosterRowViewModel.DetailItem(text: player.throwingHandCode, secondaryText: "throw")
        let batDetail = RosterRowViewModel.DetailItem(text: player.battingSideCode, secondaryText: "bat")
        let ageDetail = RosterRowViewModel.DetailItem(text: player.age.formattedStat(), secondaryText: "age")

        return [throwsDetail, batDetail, ageDetail]
    }
}
