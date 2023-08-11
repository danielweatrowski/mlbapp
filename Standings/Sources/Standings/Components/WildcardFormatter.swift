//
//  StandingsFormatter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/23/23.
//

import Foundation
import Models

struct WildcardFormatter {
    
    func formatWildcardStandings(forLeague leagueRecord: Standings.LeagueRecord) -> Standings.Wildcard.LeagueStanding {
        let leagueLeaders = leagueRecord.allRecords.filter({Int($0.rank) == 1})
        
        let leagueContenders = leagueRecord.allRecords.subtracting(leagueLeaders)
        
        let contendersSorted = leagueContenders.sorted {
            return $0.wildCardRank < $1.wildCardRank
        }
                        
        let wildcard = Standings.Wildcard.LeagueStanding(league: .national,
                                                                teamLeaders: Array(leagueLeaders),
                                                                wildcardTeamStandings: contendersSorted)
        
        return wildcard
    }
    
}
