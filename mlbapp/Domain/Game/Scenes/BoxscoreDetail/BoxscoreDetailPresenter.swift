//
//  BoxscorePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

protocol BoxscoreDetailPresentationLogic {
    func presentBoxscore(output: BoxscoreDetail.Output)
}

struct BoxscoreDetailPresenter: BoxscoreDetailPresentationLogic {
    
    let viewModel: BoxscoreDetail.ViewModel
    let players: [Int: Player]

    func presentBoxscore(output: BoxscoreDetail.Output) {
        let boxscore = output.boxscore
        let boxscoreViewModel = formatBatterBoxscore(boxscore: boxscore,
                                                     homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                     awayTeamAbbreviation: viewModel.awayTeamAbbreviation)
        
        let pitchingBoxscoreViewModel = formatPitcherBoxscore(boxscore: boxscore,
                                                              homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                              awayTeamAbbreviation: viewModel.awayTeamAbbreviation)
        
        DispatchQueue.main.async {
            viewModel.boxscoreViewModel = boxscoreViewModel
            viewModel.pitchingBoxscoreViewModel = pitchingBoxscoreViewModel
            viewModel.homeTeamBattingDetails = boxscore.home.battingDetais
            viewModel.awayTeamBattingDetails = boxscore.away.battingDetais
            viewModel.homeTeamFieldingDetails = boxscore.home.fieldingDetails
            viewModel.awayTeamFieldingDetails = boxscore.away.fieldingDetails
            viewModel.homeTeamRunningDetails = boxscore.home.baseRunningDetails
            viewModel.awayTeamRunningDetails = boxscore.away.baseRunningDetails
        }
    }
    
    private func getBoxscoreName(forPlayerID id: Int) -> String? {
        return players[id]?.boxscoreName
    }
    
    private func formatBatterBoxscore(boxscore: Boxscore?, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreGridViewModel? {
        guard let boxscore = boxscore else { return nil }
        
        let batters = [boxscore.home.batters, boxscore.away.batters]
        let teamRows = batters.map { teamBatters in
            return teamBatters.map { batter in
                
                var name = getBoxscoreName(forPlayerID: batter.playerID) ?? batter.fullName
                
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
        
        
        return BoxscoreGridViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: boxscore.home.notes,
                                 homeRows: teamRows[0],
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: boxscore.away.notes,
                                 awayRows: teamRows[1],
                                 awayTotalsRow: totals[1],
                                 type: .batters)
    }
    
    private func formatPitcherBoxscore(boxscore: Boxscore?, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreGridViewModel? {
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
        
        
        return BoxscoreGridViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: [],
                                 homeRows: teamRows[0],
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: [],
                                 awayRows: teamRows[1],
                                 awayTotalsRow: totals[1],
                                 type: .pitchers)
    }
}
