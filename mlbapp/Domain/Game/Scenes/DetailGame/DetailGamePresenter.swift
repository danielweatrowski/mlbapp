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
        
        let headerViewModel = DetailGame.HeaderViewModel(homeTeam: game.homeTeam,
                                                          homeTeamScore: String(game.homeTeamScore),
                                                          homeTeamRecord: "\(game.homeTeamWins)-\(game.homeTeamLosses)",
                                                          awayTeam: game.awayTeam,
                                                          awayTeamScore: String(game.awayTeamScore),
                                                          awayTeamRecord: "\(game.awayTeamWins)-\(game.awayTeamLosses)")
        
        let infoViewModel = DetailGame.InfoViewModel(gameDate: game.date.formatted(),
                                                     venueName: game.venue.name)
        
        let lineScoreViewModel = formatLineScore(linescore: response.linescore,
                                                 homeTeam: game.homeTeam,
                                                 awayTeam: game.awayTeam,
                                                 winner: response.boxscore.winningPitcher,
                                                 loser: response.boxscore.losingPitcher)
        
        let boxscoreViewModel = formatBoxscore(boxscore: response.boxscore,
                                               homeTeamAbbreviation: game.homeTeam.abbreviation,
                                               awayTeamAbbreviation: game.awayTeam.abbreviation)
        
        DispatchQueue.main.async {
            viewModel.headerViewModel = headerViewModel
            viewModel.infoViewModel = infoViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.boxscoreViewModel = boxscoreViewModel
        }
    }
    
    private func formatBoxscore(boxscore: MLBBoxscore, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreViewModel {
        var homeBoxItems = [BoxscoreViewModel.Batter]()
        var awayBoxBatters = [BoxscoreViewModel.Batter]()
        
        for batter in boxscore.homeBatters {
            let battingOrder = Int(batter.battingOrder ?? "100") ?? 100
            var name = batter.fullName
            
            if let note = batter.stats?.note {
                name = note + name
            }
            
            let boxscoreItem: BoxscoreViewModel.Batter = BoxscoreViewModel.Batter(name: name,
                                                      positionAbbreviation: batter.positionAbbreviation,
                                                      atBats: String(batter.stats?.atBats ?? 0),
                                                      runs: String(batter.stats?.runs ?? 0),
                                                      hits: String(batter.stats?.hits ?? 0),
                                                      runsBattedIn: String(batter.stats?.rbi ?? 0),
                                                      baseOnBalls: String(batter.stats?.baseOnBalls ?? 0),
                                                      strikeOuts: String(batter.stats?.strikeOuts ?? 0),
                                                      leftOnBase: String(batter.stats?.leftOnBase ?? 0),
                                                      average: batter.stats?.avg ?? "xxx",
                                                      substitution: battingOrder % 100 != 0)
            homeBoxItems.append(boxscoreItem)
        }
        
        let hBattingTotals = boxscore.homeBattingTotals
        let hBattingTotalsViewModel = BoxscoreViewModel.buildBattingTotals(atBats: String(hBattingTotals.atBats),
                                                                           runs: String(hBattingTotals.runs),
                                                                           hits: String(hBattingTotals.hits),
                                                                           runsBattedIn: String(hBattingTotals.rbi),
                                                                           baseOnBalls: String(hBattingTotals.baseOnBalls),
                                                                           strikeOuts: String(hBattingTotals.strikeOuts),
                                                                           leftOnBase: String(hBattingTotals.leftOnBase))
        
        for batter in boxscore.awayBatters {
            let battingOrder = Int(batter.battingOrder ?? "100") ?? 100
            var name = batter.fullName
            
            if let note = batter.stats?.note {
                name = note + name
            }
            
            let boxscoreItem: BoxscoreViewModel.Batter = BoxscoreViewModel.Batter(name: name,
                                                      positionAbbreviation: batter.positionAbbreviation,
                                                      atBats: String(batter.stats?.atBats ?? 0),
                                                      runs: String(batter.stats?.runs ?? 0),
                                                      hits: String(batter.stats?.hits ?? 0),
                                                      runsBattedIn: String(batter.stats?.rbi ?? 0),
                                                      baseOnBalls: String(batter.stats?.baseOnBalls ?? 0),
                                                      strikeOuts: String(batter.stats?.strikeOuts ?? 0),
                                                      leftOnBase: String(batter.stats?.leftOnBase ?? 0),
                                                      average: batter.stats?.avg ?? "xxx",
                                                      substitution: battingOrder % 100 != 0)
            awayBoxBatters.append(boxscoreItem)
        }
        
        let aBattingTotals = boxscore.awayBattingTotals
        let aBattingTotalsViewModel = BoxscoreViewModel.buildBattingTotals(atBats: String(aBattingTotals.atBats),
                                                                           runs: String(aBattingTotals.runs),
                                                                           hits: String(aBattingTotals.hits),
                                                                           runsBattedIn: String(aBattingTotals.rbi),
                                                                           baseOnBalls: String(aBattingTotals.baseOnBalls),
                                                                           strikeOuts: String(aBattingTotals.strikeOuts),
                                                                           leftOnBase: String(aBattingTotals.leftOnBase))
        
        let homeBattingInfo = boxscore.homeBattingInfo.map({
            BoxscoreViewModel.Info(title: $0.label, description: $0.value)
        })
        
        let homeFieldingInfo = boxscore.homeFieldingInfo.map({
            BoxscoreViewModel.Info(title: $0.label, description: $0.value)
        })
        
        let boxscoreViewModel = BoxscoreViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                                  homeNotes: boxscore.homeNotes,
                                                  homeBatters: homeBoxItems,
                                                  homeBattingTotals: hBattingTotalsViewModel,
                                                  awayTeamAbbreviation: awayTeamAbbreviation,
                                                  awayNotes: boxscore.awayNotes,
                                                  awayBatters: awayBoxBatters,
                                                  awayBattingTotals: aBattingTotalsViewModel,
                                                  homeBattingInfo: homeBattingInfo,
                                                  homeFieldingInfo: homeFieldingInfo)
        return boxscoreViewModel
    }
    
    private func formatLineScore(linescore: MLBLinescore, homeTeam: Team, awayTeam: Team, winner: MLBPitcher?, loser: MLBPitcher?) -> LineScoreViewModel {
        
        var spacer: LineScoreViewItem {
            LineScoreViewItem(id: UUID(), type: .none, value: "")
        }
        
        var awayLineItems = [LineScoreViewItem]()
        var homeLineItems = [LineScoreViewItem]()
        var headerLineItems = [LineScoreViewItem]()
    
        let a_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: awayTeam.abbreviation)
        let h_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: homeTeam.abbreviation)
        
        // Teams
        awayLineItems.append(a_nameAbbreviation)
        homeLineItems.append(h_nameAbbreviation)
        headerLineItems.append(spacer)
                
        // Innings
        for inning in linescore.innings {
            let homeInningRuns = inning.away.runs ?? 0
            let awayInningRuns = inning.home.runs ?? 0

            let h_runItem = LineScoreViewItem(id: UUID(), type: .run, value: String(homeInningRuns))
            let a_runItem = LineScoreViewItem(id: UUID(), type: .run, value: String(awayInningRuns))
            let headerItem = LineScoreViewItem(id: UUID(), type: .header, value: String(inning.num))
            
            awayLineItems.append(a_runItem)
            homeLineItems.append(h_runItem)
            headerLineItems.append(headerItem)
        }
        
        // Spacer
        awayLineItems.append(spacer)
        homeLineItems.append(spacer)
        headerLineItems.append(spacer)
        
        // Runs
        let runsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "R")
        headerLineItems.append(runsHeaderItem)
        
        let h_runsTotal = linescore.homeTotal.runs ?? 0
        let h_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_runsTotal))
        homeLineItems.append(h_runsTotalItem)
        
        let a_runsTotal = linescore.awayTotal.runs ?? 0
        let a_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_runsTotal))
        awayLineItems.append(a_runsTotalItem)
        
        // Hits
        let hitsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "H")
        headerLineItems.append(hitsHeaderItem)
        
        let h_hitsTotal = linescore.homeTotal.hits ?? 0
        let h_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_hitsTotal))
        homeLineItems.append(h_hitsTotalItem)
        
        let a_hitsTotal = linescore.awayTotal.hits ?? 0
        let a_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_hitsTotal))
        awayLineItems.append(a_hitsTotalItem)
        
        // Errors
        let errorsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "E")
        headerLineItems.append(errorsHeaderItem)
        
        let h_errorsTotal = linescore.homeTotal.errors ?? 0
        let h_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_errorsTotal))
        homeLineItems.append(h_errorsTotalItem)
        
        let a_errorsTotal = linescore.awayTotal.errors ?? 0
        let a_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_errorsTotal))
        awayLineItems.append(a_errorsTotalItem)
                
        return LineScoreViewModel(headers: headerLineItems,
                                  homeLineItems: homeLineItems,
                                  awayLineItems: awayLineItems,
                                  winningPitcherName: winner?.fullName,
                                  winningPitcherRecord: "NIL",
                                  winningPitcherERA: winner?.stats?.era,
                                  losingPitcherName: loser?.fullName,
                                  losingPitcherRecord: "NIL",
                                  losingPitcherERA: loser?.stats?.era)
        
    }
    
}
