//
//  TeamData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import Foundation

struct Team {
    let id: Int
    let name: String
    let abbreviation: String
    let teamName: String
    let locationName: String
    let venue: Venue
    let division: Division
    let league: League
    
    let record: SeasonRecord?
    
    struct MetaData {
        let id: Int
        let name: String
        let link: String
    }
    
    struct SeasonRecord {
        let gamesPlayed: Int
        let wins: Int
        let losses: Int
        let ties: Int
        let winningPercentage: String
        
        func formatted() -> String {
            return  "\(wins)-\(losses)"
        }
    }
}


