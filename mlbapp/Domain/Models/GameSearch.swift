//
//  SearchGameParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import Foundation

enum GameSearch {
    struct SearchParameters: Codable {
        let homeTeamID: Int?
        let awayTeamID: Int?
        let startDate: Date
        let endDate: Date
    }
    
    struct Result: Hashable, Codable {
        
        static func == (lhs: GameSearch.Result, rhs: GameSearch.Result) -> Bool {
            return lhs.id == rhs.id
        }
        
        func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
        }
        
        let id: Int
        let gameDate: Date
        let venueName: String
        let status: GameStatus
        let awayTeam: Team
        let homeTeam: Team
        let linescore: Linescore?
        let decisions: Decisions?
        let liveInfo: LiveInfo?
        
        struct Team: Codable {
            let id: Int
            let name: String
            let score: Int
            let wins: Int
            let losses: Int
            
            var record: String {
                return "\(wins)-\(losses)"
            }
        }
        
        struct LiveInfo: Codable {
            let currentInning: Int
            let currentInningDescription: String
            let currentInningHalf: String
        }
    }
}
