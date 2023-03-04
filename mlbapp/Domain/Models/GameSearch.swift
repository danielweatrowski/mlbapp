//
//  SearchGameParameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import Foundation

enum GameSearch {
    struct SearchParameters {
        let homeTeamID: Int
        let awayTeamID: Int?
        let startDate: Date
        let endDate: Date
    }
    
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
    }
}
