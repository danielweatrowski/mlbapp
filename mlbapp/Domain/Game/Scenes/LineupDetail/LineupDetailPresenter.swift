//
//  LineupDetailPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

protocol LineupDetailPresentationLogic {
    func presentLineups(output: LineupDetail.Output)
}

struct LineupDetailPresenter: LineupDetailPresentationLogic {
    
    let viewModel: LineupDetail.ViewModel
    
    func presentLineups(output: LineupDetail.Output) {
        
        guard let homeLineup = output.lineups.home else {
            return
        }
        
        let players = homeLineup
            .filter({$0.battingOrderIndex != nil})
            .map({$0.fullName})
        
        
        DispatchQueue.main.async {
            viewModel.homeLineup = players
        }
        
        guard let awayLineup = output.lineups.away else {
            return
        }
        
        let awayPlayers = awayLineup
            .filter({$0.battingOrderIndex != nil})
            .map({$0.fullName})
        
        
        DispatchQueue.main.async {
            viewModel.awayLineup = awayPlayers
        }
        
    }
    
    
}
