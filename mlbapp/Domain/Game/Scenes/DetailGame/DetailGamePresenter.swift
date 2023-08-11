//
//  DetailGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI
import Common
import Models

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
                                                        homeTeamName: game.homeTeam.teamName,
                                                        homeTeamAbbreviation: game.homeTeam.abbreviation,
                                                        homeTeamScore: String(game.homeTeamScore),
                                                        homeTeamRecord: homeTeamRecord.formatted(),
                                                        awayTeamID: game.awayTeam.id,
                                                        awayTeamName: game.awayTeam.teamName,
                                                        awayTeamAbbreviation: game.awayTeam.abbreviation,
                                                        awayTeamScore: String(game.awayTeamScore),
                                                        awayTeamRecord: awayTeamRecord.formatted(),
                                                        statusBannerViewModel: bannerViewModel)

        let lineScoreViewModel = formatLineScore(for: game)

        formatProbablePitchers(game: game)
        formatInfoItems(game: game)
        formatDecisions(game: game)
        
        var navigationTitle = "\(game.awayTeam.abbreviation) @ \(game.homeTeam.abbreviation)"
        if game.status == .final {
            navigationTitle = "\(game.awayTeam.abbreviation)(\(game.awayTeamScore)) @ \(game.homeTeam.abbreviation)(\(game.homeTeamScore))"
        }
        
        let previewViewModel = PreviewHeaderViewModel(homeTeamName: game.homeTeam.teamName,
                                                      homeTeamRecord: homeTeamRecord.formatted(),
                                                      homeTeamAbbreviation: game.homeTeam.abbreviation,
                                                      awayTeamName: game.awayTeam.teamName,
                                                      awayTeamRecord: awayTeamRecord.formatted(),
                                                      awayTeamAbbreviation: game.awayTeam.abbreviation,
                                                      gameDateString: game.date.formatted(),
                                                      venueName: game.venue.name)
        
        DispatchQueue.main.async {
            viewModel.navigationTitle = navigationTitle
            viewModel.previewHeaderViewModel = previewViewModel
            viewModel.headerViewModel = headerViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.homeTeamAbbreviation = game.homeTeam.abbreviation
            viewModel.awayTeamAbbreviation = game.awayTeam.abbreviation
            viewModel.gameStatus = game.status
            viewModel.state = .loaded(sections: getLayout(for: game.status))
        }
    }
    
    private func getLayout(for gameStatus: GameStatus) -> [DetailGame.Section] {
        switch gameStatus {
        case .live:
            return DetailGame.Layout.liveLayout
        case .final:
            return DetailGame.Layout.finalLayout
        case .preview:
            return DetailGame.Layout.previewLayout
        case .other:
            return []
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
                                                 pitcher: game.boxscore?.player(withID: winnerId),
                                                 player: game.players[winnerId])
            
            DispatchQueue.main.async {
                viewModel.winnerViewModel = winnerViewModel
            }
            
            let loserId = decisions.loser.id
            let loserViewModel = formatDecision(title: "Loss",
                                                 pitcher: game.boxscore?.player(withID: loserId),
                                                 player: game.players[loserId])
            
            DispatchQueue.main.async {
                viewModel.loserViewModel = loserViewModel
            }
            
            if let saverId = decisions.save?.id {
                
                let saverViewModel = formatDecision(title: "Save",
                                                    pitcher: game.boxscore?.player(withID: saverId),
                                                    player: game.players[saverId])
                
                DispatchQueue.main.async {
                    viewModel.saverViewModel = saverViewModel
                }
            }
        }
    }
    
    func formatDecision(title: String, pitcher: Boxscore_V2.Player?, player: Player?) -> GameDetailPitcherViewModel? {
        guard let pitcher = pitcher, let pitchingStats = pitcher.stats?.pitching, let seasonStats = pitcher.seasonStats?.pitching, let _ = player else {
            return nil
        }
        
        return GameDetailPitcherViewModel(titleText: title,
                                          pitcherNameText: pitcher.fullName,
                                          pitcherRecordText: seasonStats.record.formatted(.pitchingRecord),
                                          details: [
                                            .init(text: pitchingStats.inningsPitched.formatted(), secondaryText: "IP"),
                                            .init(text: pitchingStats.earnedRuns.formatted(), secondaryText: "ER"),
                                            .init(text: pitchingStats.strikeOuts.formatted(), secondaryText: "SO"),
                                            .init(text: pitchingStats.baseOnBalls.formatted(), secondaryText: "BB")
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
            case .date:
                item = DetailGame.GameInfoItem(type: type, value: game.date.formatted())
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
                                                          pitcher: game.boxscore?.player(withID: homeStarterId))
                
                DispatchQueue.main.async {
                    viewModel.probableHomeStarter = homeViewModel
                }
            }

            if let awayStarterId = probablePitchers.away?.id {
                let awyViewModel = formatProbablePitcher(title: game.awayTeam.teamName,
                                                         player: game.players[awayStarterId],
                                                         pitcher: game.boxscore?.player(withID: awayStarterId))
                
                DispatchQueue.main.async {
                    viewModel.probableAwayStarter = awyViewModel
                }
            }
        }
    }
    
    func formatProbablePitcher(title: String, player: Player?, pitcher: Boxscore_V2.Player?) -> GameDetailPitcherViewModel? {
        guard let player = player, let pitcher = pitcher, let pitchingStats = pitcher.seasonStats?.pitching else {
            return nil
        }
        
        return GameDetailPitcherViewModel(titleText: title,
                                          pitcherNameText: player.fullName,
                                          pitcherRecordText: pitchingStats.record.formatted(.pitchingRecord),
                                          details: [
                                            .init(text: pitchingStats.era.formatted(), secondaryText: "ERA"),
                                            .init(text: pitchingStats.strikeOuts.formatted(), secondaryText: "SO"),
                                            .init(text: pitchingStats.baseOnBalls.formatted(), secondaryText: "BB"),
                                            .init(text: pitchingStats.whip.formatted(), secondaryText: "WHIP")
                                          ])
    }
}

