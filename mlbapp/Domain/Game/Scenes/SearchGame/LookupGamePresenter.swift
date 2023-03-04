//
//  SearchGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation

protocol LookupGamePresentationLogic {
    func presentLookupGames(response: LookupGame.Response)
    func presentLookupError(error: LookupGame.LookupGameError)
}

class SearchGamePresenter: LookupGamePresentationLogic {
    
    var view: SearchGameDisplayLogic?
    
    func presentLookupGames(response: LookupGame.Response) {
        
        let listGameRows = response.results.map({
            ListGameRowViewModel(gameID: $0.id,
                                 gameDate: $0.gameDate.formatted(),
                                 gameVenueName: $0.venueName,
                                 homeTeamName: $0.homeTeam.name,
                                 homeTeamScore: String($0.homeTeam.score),
                                 homeTeamRecord: $0.homeTeam.record,
                                 homeTeamLogoName: "",
                                 awayTeamName: $0.awayTeam.name,
                                 awayTeamScore: String($0.awayTeam.score),
                                 awayTeamRecord: $0.awayTeam.record,
                                 awayTeamLogoName: "")
        })
        
        let listGameViewModel = ListGame.ViewModel(rows: listGameRows)
        DispatchQueue.main.async {
            
            self.view?.displayLookupResults(viewModel: listGameViewModel)
        }
    }
    
    func presentLookupError(error: LookupGame.LookupGameError) {
        view?.displayLookupError(error: error)
    }

}
