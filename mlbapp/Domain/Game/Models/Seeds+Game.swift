//
//  Seeds+Game.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

extension Seeds {
    struct Games {
        static let PHI_NYM_20190424 = Game(id: 565997,
                                  link: "/api/v1.1/game/565997/feed/live",
                                  date: Date(),
                                  homeTeam: .mets,
                                  homeTeamWins: 13,
                                  homeTeamLosses: 11,
                                  homeTeamScore: 0,
                                  awayTeam: .phillies,
                                  awayTeamScore: 6,
                                  awayTeamWins: 13,
                                  awayTeamLosses: 11,
                                  venue: Seeds.Venues.citiField,
                                  gameType: "R")
    }
    
    struct Venues {
        static let citiField = MLBVenue(id: 3289, name: "Citi Field", link: "/api/v1/venues/328")
    }
}
