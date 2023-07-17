//
//  GameDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct MLBGame: Decodable {
    let id: Int
    let gameID: String
    let type: String
    let season: String
    let venue: MLBVenue
    let gameDate: Date
    let status: MLBGameStatus
    let gameInfo: GameInfo?
    let weather: WeatherInfo?
    
    let linescore: MLBLinescore
    let boxscore: MLBBoxscore_V2
    let teams: GameTeams
    let players: [MLBPlayer]
    let decisions: MLBGameDecision?
    let probablePitchers: MLBProbablePitcher?
    
    struct GameTeams: Codable {
        let away: MLBTeam
        let home: MLBTeam
    }
    
    struct GameInfo: Codable {
        let attendance: Int?
        // Using string here bc this date format is different and fails to decode
        let firstPitch: String?
        let gameDurationMinutes: Int?
    }
    
    struct WeatherInfo: Codable {
        let condition: String?
        let temp: String?
        let wind: String?
    }
}

struct MLBPerson: Codable {
    let id: Int
    let fullName: String
    let link: String
}
