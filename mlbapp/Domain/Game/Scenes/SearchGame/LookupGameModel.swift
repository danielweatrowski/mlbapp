//
//  SearchGameModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/26/22.
//

import Foundation

enum LookupGame {
    enum LookupGame {
        struct Request {
            var homeTeamIndex: Int
            var awayTeamIndex: Int
            var startDate: Date
            var endDate: Date
            var onlyRegularSeason: Bool
        }
        
        struct Response {
            var results: [LookupGameResult]
        }
        
        struct ViewModel {
            var results: [LookupGameResult]
        }
    }
    
    enum LookupGameError: Error, CustomStringConvertible {
        case missingTeamID, noGamesFound
        
        public var description: String {
            switch self {
            case .missingTeamID:
                return "Must specify a team to look up a game."
            case .noGamesFound:
                return "No games found."
            }
        }
    }
    // Domain model
    struct LookupGameResult: Identifiable {
        
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
        
//        init() {
//            self.id = 0
//            self.link = ""
//            self.homeTeam = .any
//            self.homeTeamWins = 0
//            self.homeTeamLosses = 0
//            self.homeTeamScore = 0
//            self.awayTeam = .any
//            self.awayTeamWins = 0
//            self.awayTeamLosses = 0
//            self.awayTeamScore = 0
//            self.venueName = ""
//            self.gameType = "U"
//        }
        
    }
}

extension GameLookupResponse {
    func toLookupGameResultDomain() -> [LookupGame.LookupGameResult] {
        let games = dates.flatMap({$0.games})
        
        // 2022-05-09T22:35:00Z
        let dateFormatter = ISO8601DateFormatter()
        var domainGames = [LookupGame.LookupGameResult]()
        
        for game in games {
            let teams = game.teams
            let homeTeamID = teams.home.team.id
            let awayTeamID = teams.away.team.id
            
            guard let homeTeam = MLBTeam.team(withIdentifier: homeTeamID),
                  let awayTeam = MLBTeam.team(withIdentifier: awayTeamID),
                  let gameDate = dateFormatter.date(from: game.gameDate) else {
                break
            }
            
            let domainGameResult = LookupGame.LookupGameResult(id: game.gamePk,
                                                               link: game.link,
                                                               date: gameDate,
                                                               homeTeam: homeTeam,
                                                               homeTeamWins: teams.home.leagueRecord.wins,
                                                               homeTeamLosses: teams.home.leagueRecord.losses,
                                                               homeTeamScore: teams.home.score,
                                                               awayTeam: awayTeam,
                                                               awayTeamScore: teams.away.score,
                                                               awayTeamWins: teams.away.leagueRecord.wins,
                                                               awayTeamLosses: teams.away.leagueRecord.losses,
                                                               venueName: game.venue.name,
                                                               gameType: game.gameType)
            
            domainGames.append(domainGameResult)
        }
        
        return domainGames
    }
}
