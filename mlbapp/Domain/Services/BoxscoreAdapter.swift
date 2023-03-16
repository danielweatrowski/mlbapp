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
        let a_teamBattingStats = a_team.stats.batting
        
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
        
        let boxHomeTeam = Boxscore.Team(batters: boxHomeBatters,
                                        pitchers: homePitchers,
                                        stats: boxHomeStats,
                                        notes: boxscore.home.notes)
        
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
        
        let boxAwayTeam = Boxscore.Team(batters: boxAwayBatters,
                                        pitchers: awayPitchers,
                                        stats: boxAwayStats,
                                        notes: boxscore.away.notes)
        
        return Boxscore(home: boxHomeTeam, away: boxAwayTeam)
    }
    
}
