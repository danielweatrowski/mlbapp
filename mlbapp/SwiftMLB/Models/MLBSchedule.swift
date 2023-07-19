//
//  Schedule.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

struct MLBSchedule: Codable {
    
    let games: [Game]
    
    struct Game: Codable {
        
        let gamePk: Int
        let gameDate: Date
        let teams: Teams
        let venue: MLBVenue
        let gameType: String
        let gameInSeries: Int?
        let seriesGameNumber: Int?
        let linescore: MLBLinescore?
        let status: MLBGameStatus
        let decisions: MLBGameDecision?
        
        struct Teams: Codable {
            
            let away: TeamInfo
            let home: TeamInfo
            
            struct TeamInfo: Codable {
                
                let score: Int?
                let team: MLBTeam
                let leagueRecord: LeagueRecord
                let probablePitcher: ProbablePitcher?
                
                struct LeagueRecord: Codable {
                    
                    let wins: Int
                    let losses: Int
                    let pct: String
                }
                
                struct Team: Codable {
                    
                    let id: Int
                    let name: String
                }
                
                struct ProbablePitcher: Codable {
                    let id: Int
                    let fullName: String
                    let link: String
                }
            }
        }
        
        
    }
}
