//
//  StandingsList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation
import Models
import Views

enum StandingsList {
    
    struct ListViewModel {
        
        struct SectionItem {
            let id: UUID = UUID()
            let title: String
            let rows: [StandingsRowViewModel]
        }
        
        let sections: [SectionItem]
    }
    
    struct LoadStandings {
        struct Output {
            let nationalLeagueStandings: Standings.LeagueRecord
            let americanLeagueStandings: Standings.LeagueRecord
        }
        
        struct ViewModel {
            let nationalStandingsList: StandingsList.ListViewModel
            let americanStandingsList: StandingsList.ListViewModel
        }
    }
    
    enum FormatWildcard {
        struct Output {
            let nationalLeagueWildcard: Standings.Wildcard.LeagueStanding
            let americanLeagueWildcard: Standings.Wildcard.LeagueStanding
        }
        
        struct ViewModel {
            let wildcardStandingsList: StandingsList.ListViewModel
        }
    }
}
