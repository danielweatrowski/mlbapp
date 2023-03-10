//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/6/23.
//

import Foundation

protocol BoxscoreProtocol {
    
}

struct Boxscore: BoxscoreProtocol {
    struct Batter {
        var playerID: Int
        var name: String
        var stats: BattingStats
        var substitution: Bool
        var battingOrderIndex: String?
        var label: String?
    }
    
    struct Pitcher {
        let playerID: Int
        let name: String
        let stats: PitchingStats
    }
    
    struct Team {
        let batters: [Batter]
        let pitchers: [Pitcher]
        let stats: BattingStats
        let notes: [String]
    }
    
    struct BattingStats {
        var atBats: Int?
        var runs: Int?
        var hits: Int?
        var runsBattedIn: Int?
        var baseOnBalls: Int?
        var strikeOuts: Int?
        var leftOnBase: Int?
        var avg: String?
    }
    
    struct PitchingStats {
        let inningsPitched: String?
        let hits: Int?
        let runs: Int?
        let earnedRuns: Int?
        let baseOnBalls: Int?
        let strikeOuts: Int?
        let homeRuns: Int?
        let era: String?
    }
    
    let home: Team
    let away: Team
}
