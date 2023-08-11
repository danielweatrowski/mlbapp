//
//  TeamData.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import Foundation

public struct Team: Codable, Hashable {

    public static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public let id: Int
    public let name: String
    public let abbreviation: String
    public let teamName: String
    public let locationName: String
    public let venue: Venue
    public let division: Division
    public let league: League
    
    public let record: SeasonRecord?
    
    public init(id: Int, name: String, abbreviation: String, teamName: String, locationName: String, venue: Venue, division: Division, league: League, record: Team.SeasonRecord? = nil) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.teamName = teamName
        self.locationName = locationName
        self.venue = venue
        self.division = division
        self.league = league
        self.record = record
    }
    
//    public struct MetaData: Codable {
//        public let id: Int
//        public let name: String
//        public let link: String
//    }
    
    public struct SeasonRecord: Codable {
        
        public init(gamesPlayed: Int, wins: Int, losses: Int, ties: Int, winningPercentage: String) {
            self.gamesPlayed = gamesPlayed
            self.wins = wins
            self.losses = losses
            self.ties = ties
            self.winningPercentage = winningPercentage
        }
        
        public let gamesPlayed: Int
        public let wins: Int
        public let losses: Int
        public let ties: Int
        public let winningPercentage: String
        
        public func formatted() -> String {
            return  "\(wins)-\(losses)"
        }
    }
}


