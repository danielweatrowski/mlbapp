//
//  LineupDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

enum LineupDetail {
    
    enum State {
        case loading, loaded, error
    }
    
    struct GameLineups {
        var home: [Boxscore.Batter]?
        var away: [Boxscore.Batter]?
    }
    
    struct Output {
        let lineups: GameLineups
    }
    
    class ViewModel: ObservableObject {
        let navigationTitle = "Lineups"
        @Published var state: State = .loading

        @Published var homeLineup: [LineupRowViewModel] = []
        @Published var awayLineup: [LineupRowViewModel] = []
        
        @Published var sceneError: SceneError = SceneError()

    }
}
