//
//  Standings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

public struct Standings {

    public struct TeamRecord: Hashable, Identifiable {
        
        public let teamID: Int
        public let teamAbbreviation: String
        public let teamName: String
        
        public let rank: Int
        public let wildCardRank: Int
        public let wildCardGamesBack: String
        
        public let division: ActiveDivision
        public let league: ActiveLeague
        
        public let wins: Int
        public let losses: Int
        public let gamesBehind: String
        
        public let winPercentage: String
        public let last10Record: String
        public let streak: String
        
        public var id: Int {
            return teamID
        }
        
        public init(teamID: Int, teamAbbreviation: String, teamName: String, rank: Int, wildCardRank: Int, wildCardGamesBack: String, division: ActiveDivision, league: ActiveLeague, wins: Int, losses: Int, gamesBehind: String, winPercentage: String, last10Record: String, streak: String) {
            self.teamID = teamID
            self.teamAbbreviation = teamAbbreviation
            self.teamName = teamName
            self.rank = rank
            self.wildCardRank = wildCardRank
            self.wildCardGamesBack = wildCardGamesBack
            self.division = division
            self.league = league
            self.wins = wins
            self.losses = losses
            self.gamesBehind = gamesBehind
            self.winPercentage = winPercentage
            self.last10Record = last10Record
            self.streak = streak
        }
    }
    
    public struct DivisionRecord {
        public let division: ActiveDivision
        public let teamStandings: [TeamRecord]
    }
    
    public struct LeagueRecord {
        public let league: ActiveLeague
        public let east: DivisionRecord
        public let central: DivisionRecord
        public let west: DivisionRecord
        
        public var allRecords: Set<TeamRecord> {
            var records = Set<TeamRecord>()
            
            records.formUnion(west.teamStandings)
            records.formUnion(east.teamStandings)
            records.formUnion(central.teamStandings)
            
            return records
        }
        
        public static func createAmericanLeague(eastTeamRecords: [TeamRecord], centralTeamRecords: [TeamRecord], westTeamRecords: [TeamRecord]) -> Self {
            
            return .init(league: .american,
                         east: .init(division: .alEast,
                                     teamStandings: eastTeamRecords),
                         central: .init(division: .alCentral,
                                        teamStandings: centralTeamRecords),
                         west: .init(division: .alWest,
                                     teamStandings: westTeamRecords))
            
        }
        
        public static func createNationalLeague(eastTeamRecords: [TeamRecord], centralTeamRecords: [TeamRecord], westTeamRecords: [TeamRecord]) -> Self {
            
            return .init(league: .national,
                         east: .init(division: .nlEast,
                                     teamStandings: eastTeamRecords),
                         central: .init(division: .nlCentral,
                                        teamStandings: centralTeamRecords),
                         west: .init(division: .nlWest,
                                     teamStandings: westTeamRecords))
            
        }
    }
    
    public let nationalLeagueRecords: LeagueRecord
    public let americanLeagueRecords: LeagueRecord
    
    public init(nationalLeagueRecords: Standings.LeagueRecord, americanLeagueRecords: Standings.LeagueRecord) {
        self.nationalLeagueRecords = nationalLeagueRecords
        self.americanLeagueRecords = americanLeagueRecords
    }
}
