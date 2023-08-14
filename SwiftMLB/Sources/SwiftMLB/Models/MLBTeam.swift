//
//  Team.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

public struct MLBTeam: Codable {
    
    public let id: Int
    public let name: String
    public let abbreviation: String
    public let teamCode: String
    public let teamName: String
    public let clubName: String
    public let locationName: String
    public let firstYearOfPlay: String
    public let active: Bool
    public let venue: MLBVenue
    public let division: MLBDivision
    public let league: MLBLeague
    public let springLeague: MLBLeague?
    public let record: TeamRecord?
    
    public struct TeamRecord: Codable {
        public let gamesPlayed: Int
        public let wins: Int
        public let losses: Int
        public let winningPercentage: String
    }
}

public struct MLBDivision: Codable {
    public let id: Int
    public let name: String
}

public struct MLBLeague: Codable {
    public let id: Int
    public let name: String
    public let link: String
}
