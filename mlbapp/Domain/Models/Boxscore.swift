//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/6/23.
//

import Foundation

protocol BoxscoreProtocol {
    
}

struct Boxscore: Hashable, Equatable, Codable {
    
    struct Batter: Codable {
        var playerID: Int
        var fullName: String
        var stats: BattingStats
        var substitution: Bool
        var position: Position
        var battingOrderIndex: String?
        var label: String?
        var note: String?
    }
    
    struct Pitcher: Codable {
        let playerID: Int
        let fullName: String
        let stats: PitchingStats
    }
    
    struct Team: Codable {
        let batters: [Batter]
        let pitchers: [Pitcher]
        let stats: BattingStats
        let pitchingStats: PitchingStats
        let notes: [String]
        let battingDetais: [GameDetail]
        let fieldingDetails: [GameDetail]
        let baseRunningDetails: [GameDetail]
        
        var startingLineup: [Batter]? {
            guard !batters.isEmpty else {
                return nil
            }
            
            return batters.filter({ !$0.substitution })
        }
    }
    
    struct BattingStats: Codable {
        var atBats: Int?
        var runs: Int?
        var hits: Int?
        var rbi: Int?
        var runsBattedIn: Int?
        var baseOnBalls: Int?
        var strikeOuts: Int?
        var leftOnBase: Int?
        var avg: String?
    }
    
    struct PitchingStats: Codable {
        let inningsPitched: String?
        let hits: Int?
        let runs: Int?
        let earnedRuns: Int?
        let baseOnBalls: Int?
        let strikeOuts: Int?
        let homeRuns: Int?
        let era: String?
        let seasonWins: Int?
        let seasonLosses: Int?
        let didWin: Bool
        let didLose: Bool
        
        var recordText: String? {
            guard let seasonWins = seasonWins, let seasonLosses = seasonLosses else {
                return nil
            }
            return "\(seasonWins)-\(seasonLosses)"
        }
    }
    
    struct GameDetail: Hashable, Codable {
        let title: String
        let detail: String
    }
    
    let id: UUID = UUID()
    let home: Team
    let away: Team
    
    static func == (lhs: Boxscore, rhs: Boxscore) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}

extension Boxscore {
    func pitcher(withID id: Int)  -> Pitcher? {
        let homePitcher = home.pitchers.first(where: {$0.playerID == id})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = away.pitchers.first(where: {$0.playerID == id})
        if let pitcher = awayPitcher {
            return pitcher
        }
        return nil
    }
    
    var winningPitcher: Pitcher? {
        let homePitcher = home.pitchers.first(where: {$0.stats.didWin})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = away.pitchers.first(where: {$0.stats.didWin})
        if let pitcher = awayPitcher {
            return pitcher
        }
        return nil
    }
    
    var losingPitcher: Pitcher? {
        let homePitcher = home.pitchers.first(where: {$0.stats.didLose})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = away.pitchers.first(where: {$0.stats.didLose})
        if let pitcher = awayPitcher {
            return pitcher
        }
        
        return nil
    }
}
