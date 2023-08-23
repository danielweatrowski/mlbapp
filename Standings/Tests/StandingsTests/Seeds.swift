//
//  StandingsListSeeds.swift
//  mlbappTests
//
//  Created by Daniel Weatrowski on 7/23/23.
//

import XCTest
@testable import Standings
@testable import Models
@testable import Common

struct Seeds {
    struct Standing {
        static let standings = Models.Standings(nationalLeagueRecords: LeagueRecords.nl,
                                         americanLeagueRecords: LeagueRecords.al)
    }
    
    struct LeagueRecords {
        static let al = Models.Standings.LeagueRecord.createAmericanLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [])
        static let nl = Models.Standings.LeagueRecord.createNationalLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [TeamRecords.lad])
    }
    
    struct TeamRecords {
        static let lad = Models.Standings.TeamRecord(teamID: 119,
                                                     teamAbbreviation: "LAD",
                                                     teamName: "Los Angeles Dodgers",
                                                     season: "2023",
                                                     rank: 1,
                                                     wildCardRank: 0,
                                                     wildCardGamesBack: .init(value: nil),
                                                     division: .nlWest,
                                                     league: .national,
                                                     wins: .init(value: nil),
                                                     losses: .init(value: nil),
                                                     gamesBehind: .init(value: nil),
                                                     winPercentage: .init(value: nil),
                                                     last10Record: .init(value: nil),
                                                     streak: .init(value: nil),
                                                     runsAllowed: .init(value: nil),
                                                     runsScored: .init(value: nil),
                                                     runDifferential: .init(value: nil),
                                                     gamesPlayed: .init(value: nil))
    }
}
