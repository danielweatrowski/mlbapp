//
//  BoxscoreAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation

struct BoxscoreAdapter {
    
    let dataObject: MLBBoxscore
    
    func toDomain() -> Boxscore {
        let boxscore = dataObject
        
        let h_team = boxscore.home
        let a_team = boxscore.away
        let h_teamBattingStats = h_team.stats.batting
        let h_teamPitchingStats = h_team.stats.pitching
        let a_teamBattingStats = a_team.stats.batting
        let a_teamPitchingStats = a_team.stats.pitching
        
        let teamBatterDTOs = [h_team.batters, a_team.batters]
        let teamBatters = teamBatterDTOs.map { teamBatterDTO in
            return teamBatterDTO.map { playerDTO in
                let gameStats = playerDTO.stats?.batting
                let seasonStats = playerDTO.seasonStats.batting
                let battingOrder = Int(playerDTO.battingOrder ?? "100") ?? 100

                let battingStats = Boxscore.BattingStats(atBats: gameStats?.atBats,
                                                         runs: gameStats?.runs,
                                                         hits: gameStats?.hits,
                                                         rbi: gameStats?.rbi,
                                                         runsBattedIn: gameStats?.rbi,
                                                         baseOnBalls: gameStats?.leftOnBase,
                                                         strikeOuts: gameStats?.strikeOuts,
                                                         leftOnBase: gameStats?.leftOnBase,
                                                         avg: seasonStats?.avg)
                
                return Boxscore.Batter(playerID: playerDTO.id,
                                             fullName: playerDTO.fullName,
                                             stats: battingStats,
                                             substitution: battingOrder % 100 != 0,
                                             position: Position(code: playerDTO.position.code,
                                                                type: playerDTO.position.type,
                                                                name: playerDTO.position.name,
                                                                abbreviation: playerDTO.position.abbreviation),
                                             battingOrderIndex: playerDTO.battingOrder,
                                             note: playerDTO.stats?.batting?.note)
            }
        }
        
        let teamPitcherDTOs = [h_team.pitchers, a_team.pitchers]
        let teamPitchers = teamPitcherDTOs.map { teamPitcherDTO in
            return teamPitcherDTO.map { playerDTO in
                let gameStats = playerDTO.stats?.pitching
                let seasonStats = playerDTO.seasonStats.pitching

                let pitchingStats = Boxscore.PitchingStats(inningsPitched: gameStats?.inningsPitched,
                                                           hits: gameStats?.hits,
                                                           runs: gameStats?.runs,
                                                           earnedRuns: gameStats?.earnedRuns,
                                                           baseOnBalls: gameStats?.baseOnBalls,
                                                           strikeOuts: gameStats?.strikeOuts,
                                                           homeRuns: gameStats?.homeRuns,
                                                           era: seasonStats?.era,
                                                           seasonWins: seasonStats?.wins,
                                                           seasonLosses: seasonStats?.losses,
                                                           didWin: gameStats?.wins == 1,
                                                           didLose: gameStats?.losses == 1,
                                                           seasonStrikeouts: seasonStats?.strikeOuts,
                                                           seasonBaseOnBalls: seasonStats?.baseOnBalls)
                
                
                return Boxscore.Pitcher(playerID: playerDTO.id,
                                        fullName: playerDTO.fullName,
                                        stats: pitchingStats)
            }
        }
        
        let teamBattingStatDTOs = [h_teamBattingStats, a_teamBattingStats]
        let teamBattingStats = teamBattingStatDTOs.map { teamBattingStatDTO in
            return Boxscore.BattingStats(atBats: teamBattingStatDTO?.atBats,
                                         runs: teamBattingStatDTO?.runs,
                                         hits: teamBattingStatDTO?.hits,
                                         rbi: teamBattingStatDTO?.rbi,
                                         runsBattedIn: teamBattingStatDTO?.rbi,
                                         baseOnBalls: teamBattingStatDTO?.baseOnBalls,
                                         strikeOuts: teamBattingStatDTO?.strikeOuts,
                                         leftOnBase: teamBattingStatDTO?.leftOnBase,
                                         avg: teamBattingStatDTO?.avg)
        }
    
        let teamPitchingStatDTOs = [h_teamPitchingStats, a_teamPitchingStats]
        let teamPitchingStats = teamPitchingStatDTOs.map { teamPitchingStatDTOs in
            return Boxscore.PitchingStats(inningsPitched: h_teamPitchingStats?.inningsPitched,
                                          hits: h_teamPitchingStats?.hits,
                                          runs: h_teamPitchingStats?.runs,
                                          earnedRuns: h_teamPitchingStats?.earnedRuns,
                                          baseOnBalls: h_teamPitchingStats?.baseOnBalls,
                                          strikeOuts: h_teamPitchingStats?.strikeOuts,
                                          homeRuns: h_teamPitchingStats?.homeRuns,
                                          era: h_teamPitchingStats?.era,
                                          seasonWins: nil,
                                          seasonLosses: nil,
                                          didWin: false,
                                          didLose: false,
                                          seasonStrikeouts: nil,
                                          seasonBaseOnBalls: nil)
        }
        
        let teamBattingDetailDTOs = [boxscore.home.battingInfo, boxscore.away.battingInfo]
        let teamBattingDetail = teamBattingDetailDTOs.map { battingInfoDTO in
            return battingInfoDTO.map ({
                Boxscore.GameDetail(title: $0.label, detail: $0.value)
            })
        }
        
        let teamFieldingDetailDTOs = [boxscore.home.fieldingInfo, boxscore.away.fieldingInfo]
        let teamFieldingDetail = teamFieldingDetailDTOs.map { fieldingInfoDTO in
            return fieldingInfoDTO.map ({
                Boxscore.GameDetail(title: $0.label, detail: $0.value)
            })
        }
        
        let teamRunningDetailDTOs = [boxscore.home.baserunningInfo, boxscore.away.baserunningInfo]
        let teamRunningDetail = teamRunningDetailDTOs.map { runningInfoDTO in
            return runningInfoDTO.map ({
                Boxscore.GameDetail(title: $0.label, detail: $0.value)
            })
        }
        
        let teamNotes = [boxscore.home.notes, boxscore.away.notes]
        let teamIndices = [0, 1]
        let teams = teamIndices.map { index in
            return Boxscore.Team(batters: teamBatters[index],
                pitchers: teamPitchers[index],
                stats: teamBattingStats[index],
                pitchingStats: teamPitchingStats[index],
                notes: teamNotes[index],
                battingDetais:  teamBattingDetail[index],
                fieldingDetails: teamFieldingDetail[index],
                baseRunningDetails: teamRunningDetail[index])
        }
        
        return Boxscore(home: teams[0],
                        away: teams[1])
    }
    
}
