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
            var results: [MLBGame]
        }
        
        struct ViewModel {
            var results: [MLBGame]
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
}

extension GameLookupResponse {
    func toLookupGameResultDomain() -> [MLBGame] {
        let games = dates.flatMap({$0.games})
        
        // 2022-05-09T22:35:00Z
        let dateFormatter = ISO8601DateFormatter()
        var domainGames = [MLBGame]()
        
        for game in games {
            let teams = game.teams
            let homeTeamID = teams.home.team.id
            let awayTeamID = teams.away.team.id
            
            guard let homeTeam = MLBTeam.team(withIdentifier: homeTeamID),
                  let awayTeam = MLBTeam.team(withIdentifier: awayTeamID),
                  let gameDate = dateFormatter.date(from: game.gameDate) else {
                break
            }
            
            let domainGameResult = MLBGame(id: game.gamePk,
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
