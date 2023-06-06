//
//  DetailGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

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
        
        let formattedStatus = formatStatusBanner(gameStatus: game.status)
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
                                                        venueName: game.venue.name,
                                                        statusText: formattedStatus?.0,
                                                        statusBackgroundColor: formattedStatus?.1)

        let lineScoreViewModel = formatLineScore(for: game)
        
        let decisionsViewModel = formatDecisions(decisions: game.decisions,
                                                 boxscore: game.boxscore,
                                                 players: game.players)
        
        let probablePitchersViewModel = formatProbablePitchers(probablePitchers: game.probablePitchers,
                                                               homeTeamName: game.homeTeam.teamName,
                                                               awayTeamName: game.awayTeam.teamName)
        
        // remove all previous info items to avoid duplication
        DispatchQueue.main.async {
            viewModel.infoItems.removeAll()
        }
        
        for type in DetailGame.GameInfoItem.InfoType.allCases {
            
            var item: DetailGame.GameInfoItem?
            
            switch type {
            case .venue:
                item = DetailGame.GameInfoItem(type: type, value: game.venue.name)
            case .firstPitchTime:
                item = DetailGame.GameInfoItem(type: type, value: game.info.firstPitchDate?.formatted(date: .omitted, time: .shortened) ?? "TBD")
            case .wind:
                item = DetailGame.GameInfoItem(type: type, value: game.info.windDescription ?? "-")
            case .weather:
                item = DetailGame.GameInfoItem(type: type, value: game.info.weatherTempurature ?? "-")
            case .attendance:
                item = DetailGame.GameInfoItem(type: type, value: game.info.attendance.formattedStat())
            case .duration:
                if let duration = game.info.gameDurationInMinutes {
                    item = DetailGame.GameInfoItem(type: type, value: "\(duration) min")
                } else {
                    item = DetailGame.GameInfoItem(type: type, value: "-")
                }
            }
            
            if let item = item {
                DispatchQueue.main.async {
                    viewModel.infoItems.append(item)
                }
            }
        }
        
        DispatchQueue.main.async {
            viewModel.navigationTitle = "\(game.awayTeam.abbreviation) @ \(game.homeTeam.abbreviation)"
            viewModel.headerViewModel = headerViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.decisionsViewModel = decisionsViewModel
            viewModel.homeTeamAbbreviation = game.homeTeam.abbreviation
            viewModel.awayTeamAbbreviation = game.awayTeam.abbreviation
            viewModel.probablePitchersViewModel = probablePitchersViewModel
            
            viewModel.gameStatus = game.status
            viewModel.state = .loaded
        }
    }
    
    func formatStatusBanner(gameStatus: GameStatus) -> (String, Color)? {
        switch gameStatus {
        case .live:
            return (gameStatus.friendlyName.uppercased(), .green)
        case .final:
            return (gameStatus.friendlyName.uppercased(), .red)
        default: return nil
        }
    }
    
    func formatProbablePitchers(probablePitchers: ProbablePitchers?, homeTeamName: String, awayTeamName: String) -> ProbablePitchersViewModel? {
        guard let probablePitchers = probablePitchers, probablePitchers.hasPitcherData else {
            return nil
        }
        
        return ProbablePitchersViewModel(homeTeamName: homeTeamName,
                                         homeTeamProbablePitcher: probablePitchers.home?.fullName,
                                         awayTeamName: awayTeamName,
                                         awayTeamProbablePitcher: probablePitchers.away?.fullName)
    }
    
    func formatDecisions(decisions: Decisions?, boxscore: Boxscore?, players: [Int: Player]) -> DecisionsInfoViewModel? {
        guard let decisions = decisions, let losingPitcher = boxscore?.pitcher(withID: decisions.loser.id), let winningPitcher = boxscore?.pitcher(withID: decisions.winner.id) else {
            return nil
        }
        
        var savingPitcher: Boxscore.Pitcher?
        if let savingPitcherID = decisions.save?.id {
            savingPitcher = boxscore?.pitcher(withID: savingPitcherID)
        }
        
        return DecisionsInfoViewModel(winningPitcherName: players[winningPitcher.playerID]?.boxscoreName ?? winningPitcher.fullName,
                                             winningPitcherWins: winningPitcher.stats.seasonWins ?? 0,
                                             winningPitcherLosses: winningPitcher.stats.seasonLosses ?? 0,
                                             winningPitcherERA: winningPitcher.stats.era ?? "--",
                                      losingPitcherName: players[losingPitcher.playerID]?.boxscoreName ?? losingPitcher.fullName,
                                             losingPitcherWins: losingPitcher.stats.seasonWins ?? 0,
                                             losingPitcherLosses: losingPitcher.stats.seasonLosses ?? 0,
                                      losingPitcherERA: losingPitcher.stats.era ?? "--",
                                      savingPitcherName: players[savingPitcher?.playerID ?? -1]?.boxscoreName,
                                      savingPitcherWins: savingPitcher?.stats.seasonWins ?? 0,
                                      savingPitcherLosses: savingPitcher?.stats.seasonLosses ?? 0, savingPitcherERA: savingPitcher?.stats.era ?? "--")
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
