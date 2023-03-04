//
//  SearchGameModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/26/22.
//

import Foundation

enum SearchGame {
        
    struct Request {
        let homeTeamID: Int?
        let awayTeamID: Int?
        let startDate: Date
        let endDate: Date
    }
    
    struct Response {
        var results: [GameSearch.Result]
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
