//
//  Boxscore_V2.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

struct Boxscore_V2 {
    let away: Team
    let home: Team
    
    struct Team {
        let id: Int
        let name: String
        let teamStats: Statistics.SeasonStats?
        let players: [String: Player]
        let batters: [Int]
        let pitchers: [Int]
        let bench: [Int]
        let battingOrder: [Int]
        let info: [Info]
        let note: [ListItem]
    }
    
    enum InfoType: String {
        case batting = "BATTING"
        case fielding = "FIELDING"
        case baserunning = "BASERUNNING"
        
    }
    
    struct Info {
        let batting: [ListItem]
        let fielding: [ListItem]
        let baserunning: [ListItem]
    }
    
    struct ListItem {
        let value: String
        let label: String
    }
            
    struct Player {
        let id: Int
        let fullName: String
        let jerseyNumber: String
        let position: MLBPosition
        let stats: Statistics.GameStats?
        let seasonStats: Statistics.SeasonStats?
    }
}
