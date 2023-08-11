//
//  Standings+Wildcard.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/7/23.
//

import Foundation

public extension Standings {
    struct Wildcard {
        
        public init(americanLeague: Standings.Wildcard.LeagueStanding, nationalLeague: Standings.Wildcard.LeagueStanding) {
            self.americanLeague = americanLeague
            self.nationalLeague = nationalLeague
        }
        
        public struct LeagueStanding {
            public init(league: ActiveLeague, teamLeaders: [Standings.TeamRecord], wildcardTeamStandings: [Standings.TeamRecord]) {
                self.league = league
                self.teamLeaders = teamLeaders
                self.wildcardTeamStandings = wildcardTeamStandings
            }
            
            public let league: ActiveLeague
            // aray bc order
            public let teamLeaders: [TeamRecord]
            // array bc need order
            public let wildcardTeamStandings: [TeamRecord]
        }
        
        public let americanLeague: LeagueStanding
        public let nationalLeague: LeagueStanding
    }
}
