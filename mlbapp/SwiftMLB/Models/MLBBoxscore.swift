//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct MLBBoxscore: Codable {
    let gameId: String
    let homeBatters: [MLBBatter]
    let awayBatters: [MLBBatter]
    let homePitchers: [MLBPitcher]
    let awayPitchers: [MLBPitcher]
    let homeBattingTotals: BattingStats
    let awayBattingTotals: BattingStats
    let homePitchingTotals: PitchingStats
    let awayPitchingTotals: PitchingStats
    let homeNotes: [String]
    let awayNotes: [String]
    let homeBattingInfo: [BoxscoreInfo]
    let awayBattingInfo: [BoxscoreInfo]
    let homeFieldingInfo: [BoxscoreInfo]
    let awayFieldingInfo: [BoxscoreInfo]
    
    struct BoxscoreInfo: Codable {
        let label: String
        let value: String
    }
    
    var winningPitcher: MLBPitcher? {
        let homePitcher = homePitchers.first(where: {$0.stats?.wins == 1})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = awayPitchers.first(where: {$0.stats?.wins == 1})
        if let pitcher = awayPitcher {
            return pitcher
        }
        return nil
    }
    
    var losingPitcher: MLBPitcher? {
        let homePitcher = homePitchers.first(where: {$0.stats?.losses == 1})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = awayPitchers.first(where: {$0.stats?.losses == 1})
        if let pitcher = awayPitcher {
            return pitcher
        }
        
        return nil
    }
}
