//
//  Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct Game {
    
    var id: Int
    var link: String
    var date: Date
    var homeTeam: Team
    var homeTeamWins: Int
    var homeTeamLosses: Int
    var homeTeamScore: Int
    var awayTeam: Team
    var awayTeamScore: Int
    var awayTeamWins: Int
    var awayTeamLosses: Int
    var venue: MLBVenue
    var gameType: String
        
    var abbreviation: String {
        Team.gameAbbreviation(homeTeam: homeTeam, awayTeam: awayTeam)
    }
    
    var linescore: LineScore?
    
    init(with game: MLBSchedule.Game) {
        self.id = game.gamePk
        self.link = ""
        self.date = game.gameDate
        
        self.homeTeamWins = game.teams.home.leagueRecord.wins
        self.homeTeamLosses = game.teams.home.leagueRecord.losses
        self.homeTeam = Team.team(withIdentifier: game.teams.home.team.id)!
        self.homeTeamScore = game.teams.home.score
        
        self.awayTeamWins = game.teams.away.leagueRecord.wins
        self.awayTeamLosses = game.teams.away.leagueRecord.losses
        self.awayTeam = Team.team(withIdentifier: game.teams.away.team.id)!
        self.awayTeamScore = game.teams.away.score
        
        self.venue = MLBVenue(id: game.venue.id, name: game.venue.name, link: game.venue.link)
        self.gameType = game.gameType
    }
    
    init(id: Int, link: String, date: Date, homeTeam: Team, homeTeamWins: Int, homeTeamLosses: Int, homeTeamScore: Int, awayTeam: Team, awayTeamScore: Int, awayTeamWins: Int, awayTeamLosses: Int, venue: MLBVenue, gameType: String, linescore: Game.LineScore? = nil) {
        self.id = id
        self.link = link
        self.date = date
        self.homeTeam = homeTeam
        self.homeTeamWins = homeTeamWins
        self.homeTeamLosses = homeTeamLosses
        self.homeTeamScore = homeTeamScore
        self.awayTeam = awayTeam
        self.awayTeamScore = awayTeamScore
        self.awayTeamWins = awayTeamWins
        self.awayTeamLosses = awayTeamLosses
        self.venue = venue
        self.gameType = gameType
        self.linescore = linescore
    }
}

extension Game {
    static var test_0: Self {
        return .init(id: 662597,
                     link: "/api/v1.1/game/662597/feed/live",
                     date: Date(timeIntervalSince1970: 1662210600000),
                     homeTeam: .dodgers,
                     homeTeamWins: 91,
                     homeTeamLosses: 41,
                     homeTeamScore: 12,
                     awayTeam: .padres,
                     awayTeamScore: 74,
                     awayTeamWins: 60,
                     awayTeamLosses: 1,
                     venue: .init(id: 22, name: "Dodger Stadium", link: "/api/v1/venues/22"),
                     gameType: "R")
    }
}

// MARK: - LineScore
extension Game {
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
