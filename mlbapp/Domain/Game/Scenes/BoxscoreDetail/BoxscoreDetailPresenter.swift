//
//  BoxscorePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

protocol BoxscoreDetailPresentationLogic: SceneErrorPresentable {
    func presentBoxscore(output: BoxscoreDetail.Output)
}

struct BoxscoreDetailPresenter: BoxscoreDetailPresentationLogic {
        
    let viewModel: BoxscoreDetail.ViewModel
    
    // hash of all player info, provided from game/id endpoint
    // used here to retreive formatted boxscore name
    let players: [Int: Player]
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    func presentBoxscore(output: BoxscoreDetail.Output) {
        let boxscore = output.boxscore
        let battersBoxViewModel = formatBatterBoxscore(boxscore: boxscore,
                                                     homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                     awayTeamAbbreviation: viewModel.awayTeamAbbreviation)
        
        let pitchersBoxViewModel = formatPitcherBoxscore(boxscore: boxscore,
                                                         homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                         awayTeamAbbreviation: viewModel.awayTeamAbbreviation)
        
        DispatchQueue.main.async {
            viewModel.battingBoxscoreViewModel = battersBoxViewModel
            viewModel.pitchingBoxscoreViewModel = pitchersBoxViewModel
            
            viewModel.homeTeamBattingDetails = boxscore.home.info.batting
            viewModel.awayTeamBattingDetails = boxscore.away.info.batting
            viewModel.homeTeamFieldingDetails = boxscore.home.info.fielding
            viewModel.awayTeamFieldingDetails = boxscore.away.info.fielding
            viewModel.homeTeamRunningDetails = boxscore.home.info.baserunning
            viewModel.awayTeamRunningDetails = boxscore.away.info.baserunning
            
            viewModel.state = .loaded
        }
    }
    
    private func getBoxscoreName(playerID: Int) -> String? {
        return players[playerID]?.boxscoreName
    }
    
    private func formatBatterRows(batterIds: [Int], players: [String: Boxscore_V2.Player]) -> [BoxscoreRowViewModel] {
        let rows: [BoxscoreRowViewModel] = batterIds.compactMap { batterID in
            
            guard let player = players["ID\(batterID)"], let _ = player.battingOrder, let battingStats = player.stats?.batting, let seasontStats = player.seasonStats?.batting else {
                return nil
            }
            
            var name = getBoxscoreName(playerID: batterID) ?? player.fullName
            
            if let note = player.stats?.batting?.note {
                name = note.formatted(.none) + name
            }
            
            return BoxscoreRowViewModel(title: name,
                                        subtitle: player.position.abbreviation ?? "-",
                                        indentTitle: player.isSubstitution,
                                        item0: battingStats.atBats.formatted(.dash),
                                        item1: battingStats.runs.formatted(.dash),
                                        item2: battingStats.hits.formatted(.dash),
                                        item3: battingStats.rbi.formatted(.dash),
                                        item4: battingStats.baseOnBalls.formatted(.dash),
                                        item5: battingStats.strikeOuts.formatted(.dash),
                                        item6: battingStats.leftOnBase.formatted(.dash),
                                        item7: seasontStats.avg.formatted(.decimal))
        }
        
        return rows
        
    }
    
    private func formatBatterBoxscore(boxscore: Boxscore_V2, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreGridViewModel? {
        
        let homeBatters = boxscore.home.batters
        let homeTeamRows = formatBatterRows(batterIds: homeBatters, players: boxscore.home.players)
        
        let awayBatters = boxscore.away.batters
        let awayTeamRows = formatBatterRows(batterIds: awayBatters, players: boxscore.away.players)
        
        let teamStats = [boxscore.home.teamStats?.batting, boxscore.away.teamStats?.batting]
        let totals: [BoxscoreRowViewModel] = teamStats.compactMap { stats in
            
            guard let battingStats = stats else {
                return nil
            }
            
            return BoxscoreRowViewModel(title: "Totals",
                                 subtitle: "",
                                 boldItems: true,
                                 item0: battingStats.atBats.formatted(.dash),
                                 item1: battingStats.runs.formatted(.dash),
                                 item2: battingStats.hits.formatted(.dash),
                                 item3: battingStats.rbi.formatted(.dash),
                                 item4: battingStats.baseOnBalls.formatted(.dash),
                                 item5: battingStats.strikeOuts.formatted(.dash),
                                 item6: battingStats.leftOnBase.formatted(.dash),
                                 item7: battingStats.avg.formatted(.decimal))
        }
        
        let homeNotes = boxscore.home.note.map({
            "\($0.label)-\($0.value)"
        })
        
        let awayNotes = boxscore.away.note.map({
            "\($0.label)-\($0.value)"
        })
        
        return BoxscoreGridViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: homeNotes,
                                 homeRows: homeTeamRows,
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: awayNotes,
                                 awayRows: awayTeamRows,
                                 awayTotalsRow: totals[1],
                                 type: .batters)
    }
    
    private func formatPitcherRows(pitcherIds: [Int], players: [String: Boxscore_V2.Player]) -> [BoxscoreRowViewModel] {
        let rows: [BoxscoreRowViewModel] = pitcherIds.compactMap { pitcherID in
            
            guard let player = players["ID\(pitcherID)"], let pitcherStats = player.stats?.pitching, let seasontStats = player.seasonStats?.pitching else {
                return nil
            }
            
            let name = getBoxscoreName(playerID: pitcherID) ?? player.fullName

            return BoxscoreRowViewModel(title: name,
                                        subtitle: "P",
                                        indentTitle: false,
                                        item0: pitcherStats.inningsPitched.formatted(),
                                        item1: pitcherStats.hits.formatted(),
                                        item2: pitcherStats.runs.formatted(),
                                        item3: pitcherStats.earnedRuns.formatted(),
                                        item4: pitcherStats.baseOnBalls.formatted(),
                                        item5: pitcherStats.strikeOuts.formatted(),
                                        item6: pitcherStats.homeRuns.formatted(),
                                        item7: seasontStats.era.formatted())
        }
        
        return rows
    }
    
    private func formatPitcherBoxscore(boxscore: Boxscore_V2, homeTeamAbbreviation: String, awayTeamAbbreviation: String) -> BoxscoreGridViewModel? {
        let homePitchers = boxscore.home.pitchers
        let homePitcherRows = formatPitcherRows(pitcherIds: homePitchers, players: boxscore.home.players)
        
        let awayPitchers = boxscore.away.pitchers
        let awayPitcherRows = formatPitcherRows(pitcherIds: awayPitchers, players: boxscore.away.players)

        let teamStats = [boxscore.home.teamStats?.pitching, boxscore.away.teamStats?.pitching]
        let totals: [BoxscoreRowViewModel] = teamStats.compactMap { stats in
            
            guard let battingStats = stats else {
                return nil
            }
            
            return BoxscoreRowViewModel(title: "Totals",
                                 subtitle: "",
                                 boldItems: true,
                                 item0: battingStats.inningsPitched.formatted(.dash),
                                 item1: battingStats.hits.formatted(.dash),
                                 item2: battingStats.runs.formatted(.dash),
                                 item3: battingStats.earnedRuns.formatted(.dash),
                                 item4: battingStats.baseOnBalls.formatted(.dash),
                                 item5: battingStats.strikeOuts.formatted(.dash),
                                 item6: battingStats.homeRuns.formatted(.dash),
                                 item7: "")
        }
        
        return BoxscoreGridViewModel(homeTeamAbbreviation: homeTeamAbbreviation,
                                 homeNotes: [],
                                 homeRows: homePitcherRows,
                                 homeTotalsRow: totals[0],
                                 awayTeamAbbreviation: awayTeamAbbreviation,
                                 awayNotes: [],
                                 awayRows: awayPitcherRows,
                                 awayTotalsRow: totals[1],
                                 type: .pitchers)
    }
}
