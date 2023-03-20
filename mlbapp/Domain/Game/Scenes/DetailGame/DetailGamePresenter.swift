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
        
        let decisionsViewModel = formatDecisions(boxscore: game.boxscore)
        
        let boxscoreViewModel = formatBatterBoxscore(boxscore: game.boxscore, homeTeamAbbreviation: game.homeTeam.abbreviation, awayTeamAbbreviation: game.awayTeam.abbreviation)
        let pitchingBoxscoreViewModel = formatPitcherBoxscore(boxscore: game.boxscore, homeTeamAbbreviation: game.homeTeam.abbreviation, awayTeamAbbreviation: game.awayTeam.abbreviation)
        
        DispatchQueue.main.async {
            viewModel.navigationTitle = "\(game.awayTeam.abbreviation) @ \(game.homeTeam.abbreviation)"
            viewModel.headerViewModel = headerViewModel
            viewModel.lineScoreViewModel = lineScoreViewModel
            viewModel.decisionsViewModel = decisionsViewModel
            viewModel.boxscoreViewModel = boxscoreViewModel
            viewModel.pitchingBoxscoreViewModel = pitchingBoxscoreViewModel
            viewModel.homeTeamBattingDetails = game.boxscore?.home.battingDetais
            viewModel.awayTeamBattingDetails = game.boxscore?.away.battingDetais
            viewModel.homeTeamFieldingDetails = game.boxscore?.home.fieldingDetails
            viewModel.awayTeamFieldingDetails = game.boxscore?.away.fieldingDetails
            viewModel.homeTeamRunningDetails = game.boxscore?.home.baseRunningDetails
            viewModel.awayTeamRunningDetails = game.boxscore?.away.baseRunningDetails
            viewModel.homeTeamAbbreviation = game.homeTeam.abbreviation
            viewModel.awayTeamAbbreviation = game.awayTeam.abbreviation
        }
    }
    
    func formatDecisions(boxscore: Boxscore?) -> DecisionsInfoViewModel? {
        guard let winningPitcher = boxscore?.winningPitcher, let losingPitcher = boxscore?.losingPitcher else {
            return nil
        }
        
        return DecisionsInfoViewModel(winningPitcherName: winningPitcher.boxscoreName,
                                             winningPitcherWins: winningPitcher.stats.seasonWins ?? 0,
                                             winningPitcherLosses: winningPitcher.stats.seasonLosses ?? 0,
                                             winningPitcherERA: winningPitcher.stats.era ?? "--",
                                             losingPitcherName: losingPitcher.boxscoreName,
                                             losingPitcherWins: losingPitcher.stats.seasonWins ?? 0,
                                             losingPitcherLosses: losingPitcher.stats.seasonLosses ?? 0,
                                             losingPitcherERA: losingPitcher.stats.era ?? "--")
    }
    
    private func formatBatterBoxscore(boxscore: Boxscore?, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreViewModel? {
        guard let boxscore = boxscore else { return nil }
        
        let batters = [boxscore.home.batters, boxscore.away.batters]
        let teamRows = batters.map { teamBatters in
            return teamBatters.map { batter in
                
                var name = batter.boxscoreName
                
                if let note = batter.note {
                    name = note + name
                }
                
                return BoxscoreRowViewModel(title: name,
                                            subtitle: batter.position.abbreviation,
                                            indentTitle: batter.substitution,
                                            item0: batter.stats.atBats.formattedStat(),
                                            item1: batter.stats.runs.formattedStat(),
                                            item2: batter.stats.hits.formattedStat(),
                                            item3: batter.stats.rbi.formattedStat(),
                                            item4: batter.stats.baseOnBalls.formattedStat(),
                                            item5: batter.stats.strikeOuts.formattedStat(),
                                            item6: batter.stats.leftOnBase.formattedStat(),
                                            item7: batter.stats.avg ?? "--")
            }
        }
        
        let teamStats = [boxscore.home.stats, boxscore.away.stats]
        let totals = teamStats.map({
            BoxscoreRowViewModel(title: "Totals",
                                 subtitle: "",
                                 boldItems: true,
                                 item0: $0.atBats.formattedStat(),
                                 item1: $0.runs.formattedStat(),
                                 item2: $0.hits.formattedStat(),
                                 item3: $0.rbi.formattedStat(),
                                 item4: $0.baseOnBalls.formattedStat(),
                                 item5: $0.strikeOuts.formattedStat(),
                                 item6: $0.leftOnBase.formattedStat(),
                                 item7: $0.avg ?? "")
        })
        
        
        return BoxscoreViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: boxscore.home.notes,
                                 homeRows: teamRows[0],
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: boxscore.away.notes,
                                 awayRows: teamRows[1],
                                 awayTotalsRow: totals[1])
    }
    
    private func formatPitcherBoxscore(boxscore: Boxscore?, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreViewModel? {
        guard let boxscore = boxscore else { return nil }
        
        let pitchers = [boxscore.home.pitchers, boxscore.away.pitchers]
        let teamRows = pitchers.map { teamPitchers in
            return teamPitchers.map { pitcher in
                                
                return BoxscoreRowViewModel(title: pitcher.boxscoreName,
                                            subtitle: "P",
                                            indentTitle: false,
                                            item0: pitcher.stats.inningsPitched ?? "-",
                                            item1: pitcher.stats.hits.formattedStat(),
                                            item2: pitcher.stats.runs.formattedStat(),
                                            item3: pitcher.stats.earnedRuns.formattedStat(),
                                            item4: pitcher.stats.baseOnBalls.formattedStat(),
                                            item5: pitcher.stats.strikeOuts.formattedStat(),
                                            item6: pitcher.stats.homeRuns.formattedStat(),
                                            item7: pitcher.stats.era ?? "-")
            }
        }
        
        let teamStats = [boxscore.home.pitchingStats, boxscore.away.pitchingStats]
        let totals = teamStats.map({
            BoxscoreRowViewModel(title: "Totals",
                                 subtitle: "",
                                 boldItems: true,
                                 item0: $0.inningsPitched ?? "-",
                                 item1: $0.hits.formattedStat(),
                                 item2: $0.runs.formattedStat(),
                                 item3: $0.earnedRuns.formattedStat(),
                                 item4: $0.baseOnBalls.formattedStat(),
                                 item5: $0.strikeOuts.formattedStat(),
                                 item6: $0.homeRuns.formattedStat(),
                                 item7: $0.era ?? "")
        })
        
        
        return BoxscoreViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: [],
                                 homeRows: teamRows[0],
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: [],
                                 awayRows: teamRows[1],
                                 awayTotalsRow: totals[1])
    }
   
    private func formatLineScore(for game: Game) -> LinescoreGridViewModel? {
        
        guard let linescore = game.linescore else {
            return nil
        }
        
        var spacer: LineScoreViewItem {
            LineScoreViewItem(id: UUID(), type: .none, value: "")
        }
        
        let homeTeam = game.homeTeam
        let awayTeam = game.awayTeam
        
        var awayLineItems = [LineScoreViewItem]()
        var homeLineItems = [LineScoreViewItem]()
        var headerLineItems = [LineScoreViewItem]()
    
        let a_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: awayTeam.abbreviation)
        let h_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: homeTeam.abbreviation)
        
        // Teams
        awayLineItems.append(a_nameAbbreviation)
        homeLineItems.append(h_nameAbbreviation)
        headerLineItems.append(spacer)
        
        homeLineItems.append(spacer)
        awayLineItems.append(spacer)
        headerLineItems.append(spacer)
                
        // Innings
        for inning in linescore.innings {
            let homeInningRuns = inning.away.runs
            let awayInningRuns = inning.home.runs

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
        
        let h_runsTotal = linescore.homeTotal.runs
        let h_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_runsTotal))
        homeLineItems.append(h_runsTotalItem)
        
        let a_runsTotal = linescore.awayTotal.runs
        let a_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_runsTotal))
        awayLineItems.append(a_runsTotalItem)
        
        // Hits
        let hitsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "H")
        headerLineItems.append(hitsHeaderItem)
        
        let h_hitsTotal = linescore.homeTotal.hits
        let h_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_hitsTotal))
        homeLineItems.append(h_hitsTotalItem)
        
        let a_hitsTotal = linescore.awayTotal.hits
        let a_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_hitsTotal))
        awayLineItems.append(a_hitsTotalItem)
        
        // Errors
        let errorsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "E")
        headerLineItems.append(errorsHeaderItem)
        
        let h_errorsTotal = linescore.homeTotal.errors
        let h_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(h_errorsTotal))
        homeLineItems.append(h_errorsTotalItem)
        
        let a_errorsTotal = linescore.awayTotal.errors
        let a_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: String(a_errorsTotal))
        awayLineItems.append(a_errorsTotalItem)
                
        return LinescoreGridViewModel(headers: headerLineItems,
                                  homeLineItems: homeLineItems,
                                  awayLineItems: awayLineItems)
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
