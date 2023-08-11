//
//  LineupDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation
import Models
import Common

enum LineupDetail {
    
    enum State {
        case loading, loaded, error
    }
    
    struct GameLineups {
        var home: [Boxscore_V2.Player]?
        var away: [Boxscore_V2.Player]?
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
