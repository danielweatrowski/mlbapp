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
