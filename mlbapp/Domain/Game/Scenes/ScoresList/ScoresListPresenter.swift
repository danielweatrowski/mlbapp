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
            let linescoreViewModel = formatLineScore(gameResult: result,
                                            homeAbbreviation: homeAbbreviation,
                                            awayAbbrevation: awayAbbreviation)
            
            // show date for future games
            let statusLabel = Calendar.current.isDateInToday(result.gameDate)
            ? result.state
            : result.gameDate.formatted()
            
            return ListGameRowViewModel(gameID: result.id,
                                        gameDate: statusLabel,
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
                                        winningPitcherName: result.decisions?.winnerName,
                                        losingPitcherName: result.decisions?.loserName,
                                        savePitcherName: result.decisions?.saveName,
                                        linescoreViewModel: linescoreViewModel)
        }
        
        DispatchQueue.main.async {
            viewModel.rows = listGameRows
            viewModel.state = .loaded
        }
    }
    
    private func formatLineScore(gameResult: GameSearch.Result, homeAbbreviation: String, awayAbbrevation: String) -> LinescoreGridViewModel? {
        
        guard let linescore = gameResult.linescore else {
            return nil
        }
        
        return LinescoreGridViewModel(homeAbbreviation: homeAbbreviation,
                                      awayAbbreviation: awayAbbrevation,
                                      linescore)
    }

}
