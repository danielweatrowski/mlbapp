//
//  SearchGameModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/26/22.
//

import Foundation

enum LookupGame {
    enum LookupGame {
        
        struct Result {
            
            let id: Int
            let gameDate: Date
            let venueName: String
            let awayTeam: Team
            let homeTeam: Team

            
            struct Team {
                let id: Int
                let name: String
                let score: Int
                let wins: Int
                let losses: Int
                
                var record: String {
                    return "\(wins)-\(losses)"
                }
            }
            
            init(dto: MLBSchedule.Game) {
                self.id = dto.gamePk
                self.gameDate = dto.gameDate
                self.venueName = dto.venue.name
                
                self.homeTeam = Team(id: dto.teams.home.team.id,
                                     name: dto.teams.home.team.name,
                                     score: dto.teams.home.score,
                                     wins: dto.teams.home.leagueRecord.wins,
                                     losses: dto.teams.home.leagueRecord.losses)
                self.awayTeam = Team(id: dto.teams.away.team.id,
                                     name: dto.teams.away.team.name,
                                     score: dto.teams.away.score,
                                     wins: dto.teams.away.leagueRecord.wins,
                                     losses: dto.teams.away.leagueRecord.losses)
            }
        }
        
        struct Request {
            var homeTeamIndex: Int
            var awayTeamIndex: Int
            var startDate: Date
            var endDate: Date
            var onlyRegularSeason: Bool
        }
        
        struct Response {
            var results: [Result]
        }
        
        struct ViewModel {
            var results: [Result]
        }
    }
    
    enum LookupGameError: Error, CustomStringConvertible {
        case missingTeamID, noGamesFound, unknown(_ message: String)
        
        public var description: String {
            switch self {
            case .missingTeamID:
                return "Must specify a team to look up a game."
            case .noGamesFound:
                return "No games found."
            case let .unknown(message):
                return message
            }
        }
    }
}
