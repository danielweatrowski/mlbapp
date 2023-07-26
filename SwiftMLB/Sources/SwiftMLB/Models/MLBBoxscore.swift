//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

public struct MLBBoxscore_V2: Decodable {
    public struct Teams: Decodable {
        public let away: Team
        public let home: Team
    }
    
    public struct TeamInfo: Decodable {
        public let id: Int
        public let name: String
        public let link: String
    }
    
    public struct Team: Decodable {
        public let team: TeamInfo
        public let teamStats: MLBStatistics.TotalStats?
        public let players: [String: Player]?
        public let batters: [Int]?
        public let pitchers: [Int]?
        public let bench: [Int]?
        public let battingOrder: [Int]?
        public let info: [Info]?
        public let note: [ListItem]?
    }
    
    public struct Info: Decodable {
        public let title: String
        public let fieldList: [ListItem]?
    }
    
    public struct ListItem: Decodable {
        public let value: String
        public let label: String
    }
            
    public struct Player: Decodable {
        public let person: MLBPerson
        public let jerseyNumber: String?
        public let battingOrder: String?
        public let position: MLBPosition
        public let stats: MLBStatistics.GameStats?
        public let seasonStats: MLBStatistics.TotalStats?
    }
    
    public let teams: Teams
}
