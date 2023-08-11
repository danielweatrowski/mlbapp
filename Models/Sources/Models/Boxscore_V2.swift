//
//  Boxscore_V2.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

public struct Boxscore_V2 {
    
    public let id = UUID()
    public let away: Team
    public let home: Team
    
    public init(away: Boxscore_V2.Team, home: Boxscore_V2.Team) {
        self.away = away
        self.home = home
    }
    
    public func player(withID id: Int)  -> Player? {
        
        if let player = home.players["ID\(id)"] {
            return player
        }
        
        if let player = away.players["ID\(id)"] {
            return player
        }
        
        return nil
    }
    
    
    public struct Team {
        
        public let id: Int
        public let name: String
        public let teamStats: Statistics.SeasonStats?
        public let players: [String: Boxscore_V2.Player]
        public let batters: [Int]
        public let pitchers: [Int]
        public let bench: [Int]
        public let battingOrder: [Int]
        public let info: Info
        public let note: [ListItem]
        
        public var startingLineup: [Player]? {
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
        
        public init(id: Int, name: String, teamStats: Statistics.SeasonStats? = nil, players: [String : Boxscore_V2.Player], batters: [Int], pitchers: [Int], bench: [Int], battingOrder: [Int], info: Boxscore_V2.Info, note: [Boxscore_V2.ListItem]) {
            self.id = id
            self.name = name
            self.teamStats = teamStats
            self.players = players
            self.batters = batters
            self.pitchers = pitchers
            self.bench = bench
            self.battingOrder = battingOrder
            self.info = info
            self.note = note
        }
    }
    
    public enum InfoType: String {
        case batting = "BATTING"
        case fielding = "FIELDING"
        case baserunning = "BASERUNNING"
        
    }
    
    public struct Info {
        
        public init(batting: [Boxscore_V2.ListItem], fielding: [Boxscore_V2.ListItem], baserunning: [Boxscore_V2.ListItem]) {
            self.batting = batting
            self.fielding = fielding
            self.baserunning = baserunning
        }
        
        public let batting: [ListItem]
        public let fielding: [ListItem]
        public let baserunning: [ListItem]
    }
    
    public struct ListItem: Hashable {
        
        public init(value: String, label: String) {
            self.value = value
            self.label = label
        }
        
        public let value: String
        public let label: String
    }
            
    public struct Player {
        
        public init(id: Int, fullName: String, jerseyNumber: String, battingOrder: Int? = nil, position: Position, stats: Statistics.GameStats? = nil, seasonStats: Statistics.SeasonStats? = nil) {
            self.id = id
            self.fullName = fullName
            self.jerseyNumber = jerseyNumber
            self.battingOrder = battingOrder
            self.position = position
            self.stats = stats
            self.seasonStats = seasonStats
        }
        
        public let id: Int
        public let fullName: String
        public let jerseyNumber: String
        public let battingOrder: Int?
        public let position: Position
        public let stats: Statistics.GameStats?
        public let seasonStats: Statistics.SeasonStats?
        
        public var lookupKey: String {
            return "ID\(id)"
        }
        
        public var battingOrderIndex: Int? {
            if let battingOrder = battingOrder {
                return battingOrder / 100
            }
            return nil
        }
        
        public var isInStartingLineup: Bool {
            if let battingOrderIndex = battingOrder {
                return battingOrderIndex % 100 == 0
            }
            
            return false
        }
        
        public var isSubstitution: Bool {
            guard let battingOrderIndex = battingOrder else {
                return false
            }
            return battingOrderIndex % 100 != 0
        }
    }
}

extension Boxscore_V2: Hashable, Equatable {
    public static func == (lhs: Boxscore_V2, rhs: Boxscore_V2) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
}
