//
//  StandingsListSeeds.swift
//  mlbappTests
//
//  Created by Daniel Weatrowski on 7/23/23.
//

import XCTest
@testable import mlbapp

struct StandingsSeeds {
    struct Standings {
        static let standings = mlbapp.Standings(nationalLeagueRecords: LeagueRecords.nl,
                                         americanLeagueRecords: LeagueRecords.al)
    }
    
    struct LeagueRecords {
        static let al = mlbapp.Standings.LeagueRecord.createAmericanLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [])
        static let nl = mlbapp.Standings.LeagueRecord.createNationalLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [])
    }
    
    struct TeamRecords {
        // TODO: Create team records to test `WildcardFormatter`
    }
}
