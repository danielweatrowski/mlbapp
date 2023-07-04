//
//  Team.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct MLBTeam: Codable {
    
    let id: Int
    let name: String
    let abbreviation: String
    let teamCode: String
    let teamName: String
    let clubName: String
    let locationName: String
    let firstYearOfPlay: String
    let active: Bool
    let venue: MLBVenue
    let division: MLBDivision
    let league: MLBLeague
    let springLeague: MLBLeague?
    let record: TeamRecord?
    
    struct TeamRecord: Codable {
        let gamesPlayed: Int
        let wins: Int
        let losses: Int
        let winningPercentage: String
    }
}

struct MLBDivision: Codable {
    let id: Int
    let name: String
}

struct MLBLeague: Codable {
    let id: Int
    let name: String
}
