//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct MLBBoxscore_V2: Decodable {
    struct Teams: Decodable {
        let away: Team
        let home: Team
    }
    
    struct TeamInfo: Decodable {
        let id: Int
        let name: String
        let link: String
    }
    
    struct Team: Decodable {
        let team: TeamInfo
        let teamStats: MLBStatistics.TotalStats?
        let players: [String: Player]?
        let batters: [Int]?
        let pitchers: [Int]?
        let bench: [Int]?
        let battingOrder: [Int]?
        let info: [Info]?
        let note: [ListItem]?
    }
    
    struct Info: Decodable {
        let title: String
        let fieldList: [ListItem]?
    }
    
    struct ListItem: Decodable {
        let value: String
        let label: String
    }
            
    struct Player: Decodable {
        let person: MLBPerson
        let jerseyNumber: String?
        let battingOrder: String?
        let position: MLBPosition
        let stats: MLBStatistics.GameStats?
        let seasonStats: MLBStatistics.TotalStats?
    }
    
    let teams: Teams
    //let info: [ListItem]?
}
