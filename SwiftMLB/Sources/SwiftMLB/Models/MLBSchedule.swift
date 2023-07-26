//
//  Schedule.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

public struct MLBSchedule: Codable {
    
    public let games: [Game]
    
    public struct Game: Codable {
        
        public let gamePk: Int
        public let gameDate: Date
        public let teams: Teams
        public let venue: MLBVenue
        public let gameType: String
        public let gameInSeries: Int?
        public let seriesGameNumber: Int?
        public let linescore: MLBLinescore?
        public let status: MLBGameStatus
        public let decisions: MLBGameDecision?
        
        public struct Teams: Codable {
            
            public let away: TeamInfo
            public let home: TeamInfo
            
            public struct TeamInfo: Codable {
                
                public let score: Int?
                public let team: MLBTeam
                public let leagueRecord: LeagueRecord
                public let probablePitcher: ProbablePitcher?
                
                public struct LeagueRecord: Codable {
                    
                    public let wins: Int
                    public let losses: Int
                    public let pct: String
                }
                
                public struct Team: Codable {
                    
                    public let id: Int
                    public let name: String
                }
                
                public struct ProbablePitcher: Codable {
                    public let id: Int
                    public let fullName: String
                    public let link: String
                }
            }
        }
        
        
    }
}
