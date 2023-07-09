//
//  SummaryGame.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

struct SummaryGame {
    
    struct InningSectionViewModel: Identifiable {
        let id = UUID()
        var inningNumber: Int
        var inningName: String
        var plays: [InningPlayViewModel]
    }
    
    struct InningPlayViewModel: Identifiable {
        let id = UUID()
        let playID: Int
        let eventName: String
        let description: String
        let time: String
        let numberOfOuts: String?
    }
    
    class ViewModel: ObservableObject {
        
        enum State {
            case loading, loaded, error
        }
        
        init(gameID: Int, homeTeamName: String, awayTeamName: String) {
            self.gameID = gameID
            self.homeTeamName = homeTeamName
            self.awayTeamName = awayTeamName
        }
        
        var gameID: Int
        var homeTeamName: String
        var awayTeamName: String
        let navigationTitle = "Summary"
        @Published var state: State = .loading
        @Published var sections: [InningSectionViewModel] = []
        @Published var filterType: FilterType = .all
        
        // errors
        @Published var sceneError: SceneError = SceneError()
    }
    
    struct Output<P: PlayProtocol> {
        var plays: [P]
    }
    
    enum FilterType: CaseIterable, Identifiable, CustomStringConvertible {
        case all, hits, homeruns, scoring
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .all: return "All"
            case .hits: return "Hits"
            case .homeruns: return "Home Runs"
            case .scoring: return "Scoring Plays"
            }
        }
    }
}
