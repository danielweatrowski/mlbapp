//
//  Team.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct Team: Codable {
    let id: Int
    let name: String
    let abbreviation: String
    let teamCode: String
    let teamName: String
    let clubName: String
    let locationName: String
    let firstYearOfPlay: String
    let active: Bool
    let venue: Venue
    let division: Division
    let league: League
    let springLeague: League
    let record: TeamRecord?
}

struct TeamRecord: Codable {
    let gamesPlayed: Int
    let wins: Int
    let losses: Int
    let winningPercentage: String
}

struct Division: Codable {
    let id: Int
    let name: String
}

struct League: Codable {
    let id: Int
    let name: String
}
