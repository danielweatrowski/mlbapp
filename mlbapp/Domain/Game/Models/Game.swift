//
//  Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct MLBGame {
    var id: Int
    var link: String
    var date: Date
    var homeTeam: MLBTeam
    var homeTeamWins: Int
    var homeTeamLosses: Int
    var homeTeamScore: Int
    var awayTeam: MLBTeam
    var awayTeamScore: Int
    var awayTeamWins: Int
    var awayTeamLosses: Int
    var venueName: String
    var gameType: String
    
    var abbreviation: String {
        MLBTeam.gameAbbreviation(homeTeam: homeTeam, awayTeam: awayTeam)
    }
    
    var linescore: LineScore?
}

// MARK: - LineScore
extension MLBGame {
    struct LineScore {
        var final: LineItem
        var innings: [LineItem]
    }

    struct LineItem {
        var errors: Int
        var runs: Int
        var hits: Int
    }
}
