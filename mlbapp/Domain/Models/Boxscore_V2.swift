//
//  Boxscore_V2.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

struct Boxscore_V2 {
    let id = UUID()
    let away: Team
    let home: Team
    
    func player(withID id: Int)  -> Player? {
        
        if let player = home.players["ID\(id)"] {
            return player
        }
        
        if let player = away.players["ID\(id)"] {
            return player
        }
        
        return nil
    }
    
    struct Team {
        let id: Int
        let name: String
        let teamStats: Statistics.SeasonStats?
        let players: [String: Boxscore_V2.Player]
        let batters: [Int]
        let pitchers: [Int]
        let bench: [Int]
        let battingOrder: [Int]
        let info: Info
        let note: [ListItem]
        
        var startingLineup: [Player]? {
            guard !batters.isEmpty else {
                return nil
            }
            
            // map batter keys with players hash
            // return players who were not substituted
            var batterPlayers: [Boxscore_V2.Player] = []
            for batterID in batters {
                let batterKey = "ID\(batterID)"
                if let player = self.players[batterKey], player.isInStartingLineup {
                    batterPlayers.append(player)
                }
            }
            
            return batterPlayers
        }
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
    
    struct ListItem: Hashable {
        let value: String
        let label: String
    }
            
    struct Player {
        let id: Int
        let fullName: String
        let jerseyNumber: String
        let battingOrder: Int?
        let position: Position
        let stats: Statistics.GameStats?
        let seasonStats: Statistics.SeasonStats?
        
        var lookupKey: String {
            return "ID\(id)"
        }
        
        var battingOrderIndex: Int? {
            if let battingOrder = battingOrder {
                return battingOrder / 100
            }
            return nil
        }
        
        var isInStartingLineup: Bool {
            if let battingOrderIndex = battingOrder {
                return battingOrderIndex % 100 == 0
            }
            
            return false
        }
        
        var isSubstitution: Bool {
            guard let battingOrderIndex = battingOrder else {
                return false
            }
            return battingOrderIndex % 100 != 0
        }
    }
}

extension Boxscore_V2: Hashable, Equatable {
    static func == (lhs: Boxscore_V2, rhs: Boxscore_V2) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
