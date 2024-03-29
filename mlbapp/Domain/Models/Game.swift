//
//  Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct Game: Codable {
    let id: Int
    let date: Date
    let homeTeam: Team
    let homeTeamScore: Int
    let awayTeam: Team
    let awayTeamScore: Int
    let venue: Venue
    let players: [Int: Player]
    
    var info: Info = Info()
    
    let status: GameStatus
    let decisions: Decisions?
    let probablePitchers: ProbablePitchers?
    let linescore: Linescore?
    let boxscore: Boxscore?
    let liveInfo: GameLiveInfo?
    
    lazy var winningPitcher: Player? = {
        guard let winningPitcherID = decisions?.winner.id, let player = players[winningPitcherID] else {
            return nil
        }
        return player
    }()
    
    lazy var losingPitcher: Player? = {
        guard let losingPitcherID = decisions?.loser.id, let player = players[losingPitcherID] else {
            return nil
        }
        return player
    }()
    
    struct Info: Codable {
        var weatherTempurature: String?
        var windDescription: String?
        var firstPitchDateString: String?
        var attendance: Int?
        var gameDurationInMinutes: Int?
        
        var firstPitchDate: Date? {
            let dateFormatter = DateFormatter.iso8601TimeZoneOmitted
            return dateFormatter.date(from: firstPitchDateString ?? "")
        }
    }
}
