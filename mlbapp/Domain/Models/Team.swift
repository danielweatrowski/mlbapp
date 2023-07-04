//
//  TeamData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import Foundation

struct Team: Codable, Hashable {
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let id: Int
    let name: String
    let abbreviation: String
    let teamName: String
    let locationName: String
    let venue: Venue
    let division: Division
    let league: League
    
    let record: SeasonRecord?
    
    struct MetaData: Codable {
        let id: Int
        let name: String
        let link: String
    }
    
    struct SeasonRecord: Codable {
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


