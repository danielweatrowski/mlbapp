//
//  GameDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

public struct MLBGame: Decodable {
    public let id: Int
    public let gameID: String
    public let type: String
    public let season: String
    public let venue: MLBVenue
    public let gameDate: Date
    public let status: MLBGameStatus
    public let gameInfo: GameInfo?
    public let weather: WeatherInfo?
    public let linescore: MLBLinescore
    public let boxscore: MLBBoxscore_V2
    public let teams: GameTeams
    public let players: [MLBPlayer]
    public let decisions: MLBGameDecision?
    public let probablePitchers: MLBProbablePitcher?
    
    public struct GameTeams: Codable {
        public let away: MLBTeam
        public let home: MLBTeam
    }
    
    public struct GameInfo: Codable {
        public let attendance: Int?
        // Using string here bc this date format is different and fails to decode
        public let firstPitch: String?
        public let gameDurationMinutes: Int?
    }
    
    public struct WeatherInfo: Codable {
        public let condition: String?
        public let temp: String?
        public let wind: String?
    }
}
