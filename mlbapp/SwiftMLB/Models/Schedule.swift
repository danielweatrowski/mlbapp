//
//  Schedule.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

struct Schedule: Codable {
    
    let games: [Game]
    
    struct Game: Codable {
        let gamePk: Int
        let gameDate: Date
        let teams: Teams
        let venue: Venue
        let gameType: String
        let gameInSeries: Int?
        let seriesGameNumber: Int?
        
        struct Teams: Codable {
            let away: TeamInfo
            let home: TeamInfo
            
            struct TeamInfo: Codable {
                let score: Int
                let team: Team
                let leagueRecord: LeagueRecord
                
                struct LeagueRecord: Codable {
                    let wins: Int
                    let losses: Int
                    let pct: String
                }
                
                struct Team: Codable {
                    let id: Int
                    let name: String
                }
            }
        }
    }
}
