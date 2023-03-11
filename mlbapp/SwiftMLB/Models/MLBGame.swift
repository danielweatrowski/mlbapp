//
//  GameDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct MLBGame: Codable {
    let id: Int
    let gameID: String
    let type: String
    let season: String
    let venue: MLBVenue
    let gameDate: Date
    let linescore: MLBLinescore
    let boxscore: MLBBoxscore
    let teams: GameTeams
    let players: [MLBPlayer]
    let decisions: DecisionInfo
    
    struct GameTeams: Codable {
        let away: MLBTeam
        let home: MLBTeam
    }
    
    struct DecisionInfo: Codable {
        let winner: MLBPerson
        let loser: MLBPerson
    }
}

struct MLBPerson: Codable {
    let id: Int
    let fullName: String
    let link: String
}
