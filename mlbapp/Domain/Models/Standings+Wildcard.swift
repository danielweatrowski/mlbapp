//
//  Standings+Wildcard.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

extension Standings {
    struct Wildcard {
        
        struct LeagueStanding {
            let league: ActiveLeague
            // aray bc order
            let teamLeaders: [TeamRecord]
            // array bc need order
            let wildcardTeamStandings: [TeamRecord]
        }
        
        let americanLeague: LeagueStanding
        let nationalLeague: LeagueStanding
    }
}
