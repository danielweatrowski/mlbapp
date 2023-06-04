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

struct DetailGamePresenter: DetailGamePresentationLogic {
    var viewModel: DetailGame.ViewModel

    @MainActor
    func presentGame(response: DetailGame.DetailGame.Response) {
        let game = response.game
        
        guard let homeTeamRecord = game.homeTeam.record, let awayTeamRecord = game.awayTeam.record else {
            // TODO: Present error
            return
        }
        
        let headerViewModel = DetailGameHeaderViewModel(homeTeamID: game.homeTeam.id,
                                                        homeTeamName: game.homeTeam.teamName,
                                                        homeTeamAbbreviation: game.homeTeam.abbreviation,
                                                        homeTeamScore: String(game.homeTeamScore),
                                                        homeTeamRecord: homeTeamRecord.formatted(),
                                                        awayTeamID: game.awayTeam.id,
                                                        awayTeamName: game.awayTeam.teamName,
                                                        awayTeamAbbreviation: game.awayTeam.abbreviation,
                                                        awayTeamScore: String(game.awayTeamScore),
                                                        awayTeamRecord: awayTeamRecord.formatted(),
                                                        gameDate: game.date.formatted(),
                                                        venueName: game.venue.name)

        let lineScoreViewModel = formatLineScore(for: game)
        
        let decisionsViewModel = formatDecisions(boxscore: game.boxscore, players: game.players)
        
        DispatchQueue.main.async {
            viewModel.navigationTitle = "\(game.awayTeam.abbreviation) @ \(game.homeTeam.abbreviation)"
            viewModel.headerViewModel = headerViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.decisionsViewModel = decisionsViewModel
            viewModel.homeTeamAbbreviation = game.homeTeam.abbreviation
            viewModel.awayTeamAbbreviation = game.awayTeam.abbreviation
        }
    }
    
    func formatDecisions(boxscore: Boxscore?, players: [Int: Player]) -> DecisionsInfoViewModel? {
        guard let winningPitcher = boxscore?.winningPitcher, let losingPitcher = boxscore?.losingPitcher else {
            return nil
        }
        
        return DecisionsInfoViewModel(winningPitcherName: players[winningPitcher.playerID]?.boxscoreName ?? winningPitcher.fullName,
                                             winningPitcherWins: winningPitcher.stats.seasonWins ?? 0,
                                             winningPitcherLosses: winningPitcher.stats.seasonLosses ?? 0,
                                             winningPitcherERA: winningPitcher.stats.era ?? "--",
                                      losingPitcherName: players[losingPitcher.playerID]?.boxscoreName ?? losingPitcher.fullName,
                                             losingPitcherWins: losingPitcher.stats.seasonWins ?? 0,
                                             losingPitcherLosses: losingPitcher.stats.seasonLosses ?? 0,
                                             losingPitcherERA: losingPitcher.stats.era ?? "--")
    }
   
    private func formatLineScore(for game: Game) -> LinescoreGridViewModel? {
        
        guard let linescore = game.linescore else {
            return nil
        }
        
        return LinescoreGridViewModel(homeAbbreviation: game.homeTeam.abbreviation,
                                      awayAbbreviation: game.awayTeam.abbreviation,
                                      linescore)
    }
}

extension Optional where Wrapped == Int {
    func formattedStat() -> String {
        if let stat = self {
            return String(stat)
        } else {
            return "-"
        }
    }
}
