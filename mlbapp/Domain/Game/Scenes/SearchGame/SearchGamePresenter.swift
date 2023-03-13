//
//  SearchGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation

protocol SearchGamePresentationLogic {
    func presentLookupGames(response: SearchGame.Response)
    func presentLookupError(error: SearchGame.LookupGameError)
}

class SearchGamePresenter: SearchGamePresentationLogic {
    
    var view: SearchGameDisplayLogic?
    
    func presentLookupGames(response: SearchGame.Response) {
        
        let listGameRows = response.results.map { result in
            
            let homeTeam = ActiveTeam.team(withIdentifier: result.homeTeam.id)
            let awayTeam = ActiveTeam.team(withIdentifier: result.awayTeam.id)
            
            let homeAbbreviation = homeTeam?.abbreviation ?? "NA"
            let awayAbbreviation = awayTeam?.abbreviation ?? "NA"
            
            return ListGameRowViewModel(gameID: result.id,
                                 gameDate: result.gameDate.formatted(),
                                 gameVenueName: result.venueName,
                                 homeTeamID: result.homeTeam.id,
                                 homeTeamName: result.homeTeam.name,
                                 homeTeamAbbreviation: homeAbbreviation,
                                 homeTeamScore: String(result.homeTeam.score),
                                 homeTeamRecord: result.homeTeam.record,
                                 homeTeamLogoName: "",
                                 awayTeamID: result.awayTeam.id,
                                 awayTeamName: result.awayTeam.name,
                                 awayTeamAbbreviation: awayAbbreviation,
                                 awayTeamScore: String(result.awayTeam.score),
                                 awayTeamRecord: result.awayTeam.record,
                                 awayTeamLogoName: "")
        }
        
        let listGameViewModel = ListGame.ViewModel(rows: listGameRows)
        DispatchQueue.main.async {
            
            self.view?.displayLookupResults(viewModel: listGameViewModel)
        }
    }
    
    func presentLookupError(error: SearchGame.LookupGameError) {
        view?.displayLookupError(error: error)
    }

}
