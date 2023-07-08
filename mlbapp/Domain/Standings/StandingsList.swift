//
//  StandingsList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation


enum StandingsList {
    
    enum State {
        case loading, loaded, error
    }
    
    struct ListViewModel {
        
        struct SectionItem {
            let title: String
            let rows: [StandingsRowViewModel]
        }
        
        let sections: [SectionItem]
    }
    
    class ViewModel: ObservableObject {
        @Published var state: State = .loading
        let navigationTitle: String = "Standings"
        
        @Published var americanListViewModel: ListViewModel?
        @Published var nationalListViewModel: ListViewModel?
        
        // errors
        @Published var sceneError: SceneError = SceneError()
    }
    
    struct Output {
        let nationalLeagueStandings: Standings.LeagueRecord
        let americanLeagueStandings: Standings.LeagueRecord
    }
}
