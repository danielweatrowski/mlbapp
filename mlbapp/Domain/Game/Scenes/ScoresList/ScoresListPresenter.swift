//
//  ScoresListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import Foundation

protocol ScoresListPresentationLogic {
    func presentScoresList(output: ScoresList.Output)
}

struct ScoresListPresenter: ScoresListPresentationLogic {
    
    let viewModel: ScoresList.ViewModel
    
    func presentScoresList(output: ScoresList.Output) {
        let listGameRows = output.results.map { result in
            
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
        
        DispatchQueue.main.async {
            viewModel.rows = listGameRows
            viewModel.state = .loaded
        }
    }

}
