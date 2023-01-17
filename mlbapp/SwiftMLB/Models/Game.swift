//
//  GameDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct Game: Codable {
    let id: Int
    let gameID: String
    let type: String
    let season: String
    let venue: Venue
    let gameDate: Date
    let linescore: LineScore
    let boxscore: Boxscore
    let teams: GameTeams
    
    struct GameTeams: Codable {
        let away: Team
        let home: Team
    }
}

