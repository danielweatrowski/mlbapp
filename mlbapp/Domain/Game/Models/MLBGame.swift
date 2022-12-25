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
    var venue: MLBVenue
    var gameType: String
        
    var abbreviation: String {
        MLBTeam.gameAbbreviation(homeTeam: homeTeam, awayTeam: awayTeam)
    }
    
    var linescore: LineScore?
    
    init(from gameDictionary: [String: Any]) {
        let dateFormatter = ISO8601DateFormatter()
        let game = gameDictionary
        
        self.id = game["gamePk"] as? Int ?? -1
        self.link = game["link"] as? String ?? ""
        self.gameType =  game["gameType"] as? String ?? "NA"
        
        let gameDateString = game["gameDate"] as! String
        self.date = dateFormatter.date(from: gameDateString)!
        
        let teamsDict = game["teams"] as! [String: Any]
        let venueDict = game["venue"] as! [String: Any]
        let awayTeamDict = teamsDict["away"] as! [String: Any]
        let awayTeamInfo = awayTeamDict["team"] as! [String: Any]
        let awayLeagueRecord = awayTeamDict["leagueRecord"] as! [String: Any]
        let homeTeamDict = teamsDict["home"] as! [String: Any]
        let homeTeamInfo = homeTeamDict["team"] as! [String: Any]
        let homeLeagueRecord = homeTeamDict["leagueRecord"] as! [String: Any]
        
        let venueName = venueDict["name"] as! String
        let venueID = venueDict["id"] as! Int
        let venueLink = venueDict["link"] as! String
        
        self.venue = MLBVenue(id: venueID, name: venueName, link: venueLink)

        self.homeTeamWins = homeLeagueRecord["wins"] as? Int ?? 0
        self.awayTeamWins = awayLeagueRecord["wins"] as? Int ?? 0

        self.homeTeamLosses = homeLeagueRecord["losses"] as? Int ?? 0
        self.awayTeamLosses = awayLeagueRecord["losses"] as? Int ?? 0

        self.homeTeamScore = homeTeamDict["score"] as? Int ?? 0
        self.awayTeamScore = awayTeamDict["score"] as? Int ?? 0
        
        let awayTeamID = awayTeamInfo["id"] as! Int
        let homeTeamID = homeTeamInfo["id"] as! Int
        self.awayTeam = MLBTeam.team(withIdentifier: awayTeamID) ?? .unknown
        self.homeTeam = MLBTeam.team(withIdentifier: homeTeamID) ?? .unknown
    }
    
    init(id: Int, link: String, date: Date, homeTeam: MLBTeam, homeTeamWins: Int, homeTeamLosses: Int, homeTeamScore: Int, awayTeam: MLBTeam, awayTeamScore: Int, awayTeamWins: Int, awayTeamLosses: Int, venue: MLBVenue, gameType: String, linescore: MLBGame.LineScore? = nil) {
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

extension MLBGame {
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
