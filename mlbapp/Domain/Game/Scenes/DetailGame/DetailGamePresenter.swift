//
//  DetailGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

protocol DetailGamePresentationLogic {
    func presentGame(response: DetailGame.DetailGame.Response)
}

class DetailGamePresenter: DetailGamePresentationLogic {
    var view: DetailGameDisplayLogic?
    
    func presentGame(response: DetailGame.DetailGame.Response) {
        let game = response.game
        let headerViewModel = DetailGame.DetailGame.ViewModel.DetailGameHeader(homeTeam: game.homeTeam,
                                                          homeTeamScore: String(game.homeTeamScore),
                                                          homeTeamRecord: "\(game.homeTeamWins)-\(game.homeTeamLosses)",
                                                          awayTeam: game.awayTeam,
                                                          awayTeamScore: String(game.awayTeamScore),
                                                          awayTeamRecord: "\(game.awayTeamWins)-\(game.awayTeamLosses)")
        
        let infoViewModel = DetailGame.DetailGame.ViewModel.InfoViewModel(gameDate: game.date.formatted(),
                                                                          venueName: game.venueName)
        
        let viewModel = DetailGame.DetailGame.ViewModel(headerViewModel: headerViewModel,
                                                        infoViewModel: infoViewModel)
        view?.displayGame(viewModel: viewModel)
    }
    
    
}
