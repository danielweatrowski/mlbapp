//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct MLBBoxscore: Codable {
    let gameId: String
    let home: Team
    let away: Team
        
    struct BoxscoreInfo: Codable {
        let label: String
        let value: String
    }
    
    // Decisions
    // boxscore node does not contain decision data
    var winningPitcher: Player? {
        let homePitcher = home.pitchers.first(where: {$0.stats?.pitching.wins == 1})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = away.pitchers.first(where: {$0.stats?.pitching.wins == 1})
        if let pitcher = awayPitcher {
            return pitcher
        }
        return nil
    }
    
    var losingPitcher: Player? {
        let homePitcher = home.pitchers.first(where: {$0.stats?.pitching.losses == 1})
        if let pitcher = homePitcher {
            return pitcher
        }
        
        let awayPitcher = away.pitchers.first(where: {$0.stats?.pitching.losses == 1})
        if let pitcher = awayPitcher {
            return pitcher
        }
        
        return nil
    }
}
