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
        
        public let season: String
        
        public let rank: Int
        public let wildCardRank: Int
        public let wildCardGamesBack: Stat<String>
        
        public let division: ActiveDivision
        public let league: ActiveLeague
        
        public let wins: Stat<Int>
        public let losses: Stat<Int>
        public let gamesBehind: Stat<String>
        
        public let winPercentage: Stat<String>
        public let last10Record: Stat<String>
        public let streak: Stat<String>
        
//        public let runsAllowed: Stat<Int>
//        public let runsScored: Stat<Int>
//        public let runDifferential: Stat<Int>
//        public let gamesPlayed: Stat<Int>
        
        public var id: Int {
            return teamID
        }
        
        public init(teamID: Int, teamAbbreviation: String, teamName: String, season: String, rank: Int, wildCardRank: Int, wildCardGamesBack: Stat<String>, division: ActiveDivision, league: ActiveLeague, wins: Stat<Int>, losses: Stat<Int>, gamesBehind: Stat<String>, winPercentage: Stat<String>, last10Record: Stat<String>, streak: Stat<String>) {
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
            self.season = season
        }
        
        public static func == (lhs: Standings.TeamRecord, rhs: Standings.TeamRecord) -> Bool {
            return lhs.teamID == rhs.teamID
        }
        
        public func hash(into hasher: inout Hasher) {
            return hasher.combine(id)
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
