//
//  BoxscoreAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation

struct BoxscoreAdapter {
    
    let dataObject: MLBBoxscore
    let playersHash: [Int: Player]
    
    func toDomain() -> Boxscore {
        let boxscore = dataObject
        
        let h_team = boxscore.home
        let a_team = boxscore.away
        let h_teamBattingStats = h_team.stats.batting
        let h_teamPitchingStats = h_team.stats.pitching
        let a_teamBattingStats = a_team.stats.batting
        let a_teamPitchingStats = a_team.stats.pitching
        
        let boxHomeBatters = h_team.batters.map { playerDTO in
            
            let gameStats = playerDTO.stats?.batting
            let seasonStats = playerDTO.seasonStats.batting
            let battingOrder = Int(playerDTO.battingOrder ?? "100") ?? 100

            let boxscoreName = playersHash[playerDTO.id]?.boxscoreName ?? playerDTO.fullName
            let battingStats = Boxscore.BattingStats(atBats: gameStats?.atBats,
                                                     runs: gameStats?.runs,
                                                     hits: gameStats?.hits,
                                                     rbi: gameStats?.rbi,
                                                     runsBattedIn: gameStats?.rbi,
                                                     baseOnBalls: gameStats?.leftOnBase,
                                                     strikeOuts: gameStats?.strikeOuts,
                                                     leftOnBase: gameStats?.leftOnBase,
                                                     avg: seasonStats.avg)
                        
            return Boxscore.Batter(playerID: playerDTO.id,
                                         fullName: playerDTO.fullName,
                                         boxscoreName: boxscoreName,
                                         stats: battingStats,
                                         substitution: battingOrder % 100 != 0,
                                         position: Position(code: playerDTO.position.code,
                                                            type: playerDTO.position.type,
                                                            name: playerDTO.position.name,
                                                            abbreviation: playerDTO.position.abbreviation),
                                         battingOrderIndex: playerDTO.battingOrder,
                                         note: playerDTO.stats?.batting.note)
            
        }
        
        let homePitchers = h_team.pitchers.map { playerDTO in
            let gameStats = playerDTO.stats?.pitching
            let seasonStats = playerDTO.seasonStats.pitching
            let boxscoreName = playersHash[playerDTO.id]?.boxscoreName ?? playerDTO.fullName

            let pitchingStats = Boxscore.PitchingStats(inningsPitched: gameStats?.inningsPitched,
                                                       hits: gameStats?.hits,
                                                       runs: gameStats?.runs,
                                                       earnedRuns: gameStats?.earnedRuns,
                                                       baseOnBalls: gameStats?.baseOnBalls,
                                                       strikeOuts: gameStats?.strikeOuts,
                                                       homeRuns: gameStats?.homeRuns,
                                                       era: seasonStats.era,
                                                       seasonWins: seasonStats.wins,
                                                       seasonLosses: seasonStats.losses,
                                                       didWin: gameStats?.wins == 1,
                                                       didLose: gameStats?.losses == 1)
            
            
            return Boxscore.Pitcher(playerID: playerDTO.id,
                                    fullName: playerDTO.fullName,
                                    boxscoreName: boxscoreName,
                                    stats: pitchingStats)
        }
        let boxHomeStats = Boxscore.BattingStats(atBats: h_teamBattingStats.atBats,
                                                 runs: h_teamBattingStats.runs,
                                                 hits: h_teamBattingStats.hits,
                                                 rbi: h_teamBattingStats.rbi,
                                                 runsBattedIn: h_teamBattingStats.rbi,
                                                 baseOnBalls: h_teamBattingStats.baseOnBalls,
                                                 strikeOuts: h_teamBattingStats.strikeOuts,
                                                 leftOnBase: h_teamBattingStats.leftOnBase,
                                                 avg: h_teamBattingStats.avg)
        
        let boxHomePitchingStats = Boxscore.PitchingStats(inningsPitched: h_teamPitchingStats.inningsPitched,
                                                          hits: h_teamPitchingStats.hits,
                                                          runs: h_teamPitchingStats.runs,
                                                          earnedRuns: h_teamPitchingStats.earnedRuns,
                                                          baseOnBalls: h_teamPitchingStats.baseOnBalls,
                                                          strikeOuts: h_teamPitchingStats.strikeOuts,
                                                          homeRuns: h_teamPitchingStats.homeRuns,
                                                          era: h_teamPitchingStats.era,
                                                          seasonWins: nil,
                                                          seasonLosses: nil,
                                                          didWin: false,
                                                          didLose: false)
        
        let h_battingDetails = boxscore.home.battingInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        
        let h_fieldingDetails = boxscore.home.fieldingInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        
        let h_runningDetails = boxscore.home.baserunningInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        let boxHomeTeam = Boxscore.Team(batters: boxHomeBatters,
                                        pitchers: homePitchers,
                                        stats: boxHomeStats,
                                        pitchingStats: boxHomePitchingStats,
                                        notes: boxscore.home.notes,
                                        battingDetais: h_battingDetails,
                                        fieldingDetails: h_fieldingDetails,
                                        baseRunningDetails: h_runningDetails)
        
        let boxAwayBatters = a_team.batters.map { playerDTO in
            
            let gameStats = playerDTO.stats?.batting
            let seasonStats = playerDTO.seasonStats.batting
            let battingOrder = Int(playerDTO.battingOrder ?? "100") ?? 100
            let boxscoreName = playersHash[playerDTO.id]?.boxscoreName ?? playerDTO.fullName

            let battingStats = Boxscore.BattingStats(atBats: gameStats?.atBats,
                                                     runs: gameStats?.runs,
                                                     hits: gameStats?.hits,
                                                     rbi: gameStats?.rbi,
                                                     runsBattedIn: gameStats?.rbi,
                                                     baseOnBalls: gameStats?.leftOnBase,
                                                     strikeOuts: gameStats?.strikeOuts,
                                                     leftOnBase: gameStats?.leftOnBase,
                                                     avg: seasonStats.avg)
                        
            return Boxscore.Batter(playerID: playerDTO.id,
                                         fullName: playerDTO.fullName,
                                         boxscoreName: boxscoreName,
                                         stats: battingStats,
                                         substitution: battingOrder % 100 != 0,
                                         position: Position(code: playerDTO.position.code,
                                                            type: playerDTO.position.type,
                                                            name: playerDTO.position.name,
                                                            abbreviation: playerDTO.position.abbreviation),
                                         battingOrderIndex: playerDTO.battingOrder,
                                         note: playerDTO.stats?.batting.note)
            
        }
        let awayPitchers = a_team.pitchers.map { playerDTO in
            let gameStats = playerDTO.stats?.pitching
            let seasonStats = playerDTO.seasonStats.pitching
            let boxscoreName = playersHash[playerDTO.id]?.boxscoreName ?? playerDTO.fullName

            let pitchingStats = Boxscore.PitchingStats(inningsPitched: gameStats?.inningsPitched,
                                                       hits: gameStats?.hits,
                                                       runs: gameStats?.runs,
                                                       earnedRuns: gameStats?.earnedRuns,
                                                       baseOnBalls: gameStats?.baseOnBalls,
                                                       strikeOuts: gameStats?.strikeOuts,
                                                       homeRuns: gameStats?.homeRuns,
                                                       era: seasonStats.era,
                                                       seasonWins: seasonStats.wins,
                                                       seasonLosses: seasonStats.losses,
                                                       didWin: gameStats?.wins == 1,
                                                       didLose: gameStats?.losses == 1)
            
            return Boxscore.Pitcher(playerID: playerDTO.id,
                                    fullName: playerDTO.fullName,
                                    boxscoreName: boxscoreName,
                                    stats: pitchingStats)
        }
        let boxAwayStats = Boxscore.BattingStats(atBats: a_teamBattingStats.atBats,
                                                 runs: a_teamBattingStats.runs,
                                                 hits: a_teamBattingStats.hits,
                                                 rbi: a_teamBattingStats.rbi,
                                                 runsBattedIn: a_teamBattingStats.rbi,
                                                 baseOnBalls: a_teamBattingStats.baseOnBalls,
                                                 strikeOuts: a_teamBattingStats.strikeOuts,
                                                 leftOnBase: a_teamBattingStats.leftOnBase,
                                                 avg: a_teamBattingStats.avg)
        
        let boxAwayPitchingStats = Boxscore.PitchingStats(inningsPitched: a_teamPitchingStats.inningsPitched,
                                                          hits: a_teamPitchingStats.hits,
                                                          runs: a_teamPitchingStats.runs,
                                                          earnedRuns: a_teamPitchingStats.earnedRuns,
                                                          baseOnBalls: a_teamPitchingStats.baseOnBalls,
                                                          strikeOuts: a_teamPitchingStats.strikeOuts,
                                                          homeRuns: a_teamPitchingStats.homeRuns,
                                                          era: a_teamPitchingStats.era,
                                                          seasonWins: nil,
                                                          seasonLosses: nil,
                                                          didWin: false,
                                                          didLose: false)
        
        let a_battingDetails = boxscore.away.battingInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        let a_fieldingDetails = boxscore.away.fieldingInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        let a_runningDetails = boxscore.away.baserunningInfo.map({
            Boxscore.GameDetail(title: $0.label, detail: $0.value)
        })
        
        let boxAwayTeam = Boxscore.Team(batters: boxAwayBatters,
                                        pitchers: awayPitchers,
                                        stats: boxAwayStats,
                                        pitchingStats: boxAwayPitchingStats,
                                        notes: boxscore.away.notes,
                                        battingDetais: a_battingDetails,
                                        fieldingDetails: a_fieldingDetails,
                                        baseRunningDetails: a_runningDetails)
        
        return Boxscore(home: boxHomeTeam,
                        away: boxAwayTeam)
    }
    
}
