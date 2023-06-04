//
//  ListGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/24/23.
//

import Foundation

struct ListGamePresenter {
    
    var viewModel: ListGame.ViewModel
    
    func presentLookupGames(response: ListGame.Response) {
        
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
                                    awayTeamLogoName: "",
                                    winningPitcherName: nil,
                                    losingPitcherName: nil,
                                    savePitcherName: nil,
                                    linescoreViewModel: nil)
        }
        
        DispatchQueue.main.async {
            viewModel.rows = listGameRows
        }
    }
}
