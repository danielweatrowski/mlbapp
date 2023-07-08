//
//  Standings.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

struct Standings {
    
    struct TeamRecord {
        let teamID: Int
        let teamAbbreviation: String
        let teamName: String
        
        let rank: Int
        let division: ActiveDivision
        let league: ActiveLeague
        
        let wins: Int
        let losses: Int
        let gamesBehind: String
        
        let winPercentage: String
        let last10Record: String
        let streak: String
    }
    
    struct DivisionRecord {
        let division: ActiveDivision
        let teamStandings: [TeamRecord]
    }
    
    struct LeagueRecord {
        let league: ActiveLeague
        let east: DivisionRecord
        let central: DivisionRecord
        let west: DivisionRecord
        
        static func createAmericanLeague(eastTeamRecords: [TeamRecord], centralTeamRecords: [TeamRecord], westTeamRecords: [TeamRecord]) -> Self {
            
            return .init(league: .american,
                         east: .init(division: .alEast,
                                     teamStandings: eastTeamRecords),
                         central: .init(division: .alCentral,
                                        teamStandings: centralTeamRecords),
                         west: .init(division: .alWest,
                                     teamStandings: westTeamRecords))
            
        }
        
        static func createNationalLeague(eastTeamRecords: [TeamRecord], centralTeamRecords: [TeamRecord], westTeamRecords: [TeamRecord]) -> Self {
            
            return .init(league: .national,
                         east: .init(division: .nlEast,
                                     teamStandings: eastTeamRecords),
                         central: .init(division: .nlCentral,
                                        teamStandings: centralTeamRecords),
                         west: .init(division: .nlWest,
                                     teamStandings: westTeamRecords))
            
        }
    }
    
    let nationalLeagueRecords: LeagueRecord
    let americanLeagueRecords: LeagueRecord
}
