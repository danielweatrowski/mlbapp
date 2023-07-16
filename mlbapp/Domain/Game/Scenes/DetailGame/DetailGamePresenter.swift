//
//  DetailGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

protocol DetailGamePresentationLogic {
    func presentGame(response: DetailGame.DetailGame.Response)
    func presentSceneError(_ sceneError: SceneError)
}

struct DetailGamePresenter: DetailGamePresentationLogic {
    var viewModel: DetailGame.ViewModel
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }


    @MainActor
    func presentGame(response: DetailGame.DetailGame.Response) {
        let game = response.game
        
        guard let homeTeamRecord = game.homeTeam.record, let awayTeamRecord = game.awayTeam.record else {
            self.presentSceneError(SceneError(errorDescription: "Did find nil Team.record values"))
            return
        }
        
        let bannerViewModel = formatBanner(game: game)
        let headerViewModel = DetailGameHeaderViewModel(homeTeamID: game.homeTeam.id,
                                                        homeTeamName: game.homeTeam.name,
                                                        homeTeamAbbreviation: game.homeTeam.abbreviation,
                                                        homeTeamScore: String(game.homeTeamScore),
                                                        homeTeamRecord: homeTeamRecord.formatted(),
                                                        awayTeamID: game.awayTeam.id,
                                                        awayTeamName: game.awayTeam.name,
                                                        awayTeamAbbreviation: game.awayTeam.abbreviation,
                                                        awayTeamScore: String(game.awayTeamScore),
                                                        awayTeamRecord: awayTeamRecord.formatted(),
                                                        statusBannerViewModel: bannerViewModel)

        let lineScoreViewModel = formatLineScore(for: game)

        formatProbablePitchers(game: game)
        formatInfoItems(game: game)
        formatDecisions(game: game)
        
        DispatchQueue.main.async {
            viewModel.navigationTitle = "\(game.awayTeam.abbreviation) @ \(game.homeTeam.abbreviation)"
            viewModel.headerViewModel = headerViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.homeTeamAbbreviation = game.homeTeam.abbreviation
            viewModel.awayTeamAbbreviation = game.awayTeam.abbreviation
            viewModel.gameStatus = game.status
            viewModel.state = .loaded
        }
    }
   
    private func formatLineScore(for game: Game) -> LinescoreGridViewModel? {
        
        guard let linescore = game.linescore else {
            return nil
        }
        
        return LinescoreGridViewModel(homeAbbreviation: game.homeTeam.abbreviation,
                                      awayAbbreviation: game.awayTeam.abbreviation,
                                      linescore)
    }
    
    private func formatBanner(game: Game) -> StatusBannerViewModel {
        switch game.status {
        case .live:
            
            var currentInningText: String?
            if let liveInfo = game.liveInfo {
                currentInningText = "\(liveInfo.inningState) \(liveInfo.currentInningDescription)"
            }
            
            return StatusBannerViewModel(statusText: currentInningText ?? "LIVE", secondaryStatusText: game.venue.name, backgroundColor: .green, chevronIndicator: false)
        case .final:
            return StatusBannerViewModel(statusText: "FINAL", statusTextColor: .red, secondaryStatusText: game.venue.name, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true, chevronIndicator: false)
        default:
            let text = game.date.formatted(date: .omitted, time: .shortened)
            return StatusBannerViewModel(statusText: text, statusTextColor: .secondary, secondaryStatusText: game.venue.name, secondaryStatusTextColor: .secondary, backgroundColor: .clear, divider: true, chevronIndicator: false)
        }
    }
}

// MARK: Decisions
extension DetailGamePresenter {
    func formatDecisions(game: Game) {
        if let decisions = game.decisions {
            let winnerId = decisions.winner.id
            let winnerViewModel = formatDecision(title: "Win",
                                                 pitcher: game.boxscore?.pitcher(withID: winnerId),
                                                 player: game.players[winnerId])
            
            DispatchQueue.main.async {
                viewModel.winnerViewModel = winnerViewModel
            }
            
            let loserId = decisions.loser.id
            let loserViewModel = formatDecision(title: "Loss",
                                                 pitcher: game.boxscore?.pitcher(withID: loserId),
                                                 player: game.players[loserId])
            
            DispatchQueue.main.async {
                viewModel.loserViewModel = loserViewModel
            }
            
            if let saverId = decisions.save?.id {
                
                let saverViewModel = formatDecision(title: "Save",
                                                    pitcher: game.boxscore?.pitcher(withID: saverId),
                                                    player: game.players[saverId])
                
                DispatchQueue.main.async {
                    viewModel.saverViewModel = saverViewModel
                }
            }
        }
    }
    
    func formatDecision(title: String, pitcher: Boxscore.Pitcher?, player: Player?) -> GameDetailPitcherViewModel? {
        guard let pitcher = pitcher, let _ = player else {
            return nil
        }
        
        return GameDetailPitcherViewModel(titleText: title,
                                          pitcherNameText: pitcher.fullName,
                                          pitcherRecordText: pitcher.stats.recordText ?? "",
                                          details: [
                                            .init(text: pitcher.stats.inningsPitched ?? "-1", secondaryText: "IP"),
                                            .init(text: pitcher.stats.earnedRuns.formattedStat(), secondaryText: "ER"),
                                            .init(text: pitcher.stats.strikeOuts.formattedStat(), secondaryText: "SO"),
                                            .init(text: pitcher.stats.baseOnBalls.formattedStat(), secondaryText: "BB")
                                          ])
    }
}

extension DetailGamePresenter {
    func formatInfoItems(game: Game) {
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
    }
}

// MARK: - Propable Pitcher
extension DetailGamePresenter {
    func formatProbablePitchers(game: Game) {
        if let probablePitchers = game.probablePitchers {
            
            if let homeStarterId = probablePitchers.home?.id {
                let homeViewModel = formatProbablePitcher(title: game.homeTeam.teamName,
                                                          player: game.players[homeStarterId],
                                                          pitcher: game.boxscore?.pitcher(withID: homeStarterId))
                
                DispatchQueue.main.async {
                    viewModel.probableHomeStarter = homeViewModel
                }
            }

            if let awayStarterId = probablePitchers.away?.id {
                let awyViewModel = formatProbablePitcher(title: game.awayTeam.teamName,
                                                         player: game.players[awayStarterId],
                                                         pitcher: game.boxscore?.pitcher(withID: awayStarterId))
                
                DispatchQueue.main.async {
                    viewModel.probableAwayStarter = awyViewModel
                }
            }
        }
    }
    
    func formatProbablePitcher(title: String, player: Player?, pitcher: Boxscore.Pitcher?) -> GameDetailPitcherViewModel? {
        guard let player = player, let pitcher = pitcher else {
            return nil
        }
        
        return GameDetailPitcherViewModel(titleText: title,
                                          pitcherNameText: player.fullName,
                                          pitcherRecordText: pitcher.stats.recordText ?? "",
                                          details: [
                                            .init(text: pitcher.stats.era ?? "99", secondaryText: "ERA"),
                                            .init(text: pitcher.stats.seasonStrikeouts.formattedStat(), secondaryText: "SO"),
                                            .init(text: pitcher.stats.seasonBaseOnBalls.formattedStat(), secondaryText: "BB")
                                          ])
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

