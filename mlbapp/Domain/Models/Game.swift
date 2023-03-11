//
//  Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct Game {
    let id: Int
    let date: Date
    let homeTeam: Team
    let homeTeamScore: Int
    let awayTeam: Team
    let awayTeamScore: Int
    let venue: Venue
    let players: [Int: Player]
    
    let winningPitcherID: Int?
    let losingPitcherID: Int?
    
    let linescore: Linescore?
    let boxscore: Boxscore?
    
    lazy var winningPitcher: Player? = {
        guard let winningPitcherID = winningPitcherID, let player = players[winningPitcherID] else {
            return nil
        }
        return player
    }()
    
    lazy var losingPitcher: Player? = {
        guard let losingPitcherID = losingPitcherID, let player = players[losingPitcherID] else {
            return nil
        }
        return player
    }()
    
//    lazy var playerHash: [Int: Player] = {
//        return players.reduce(into: [Int: Player]()) {
//            $0[$1.id] = $1
//        }
//    }()
}
