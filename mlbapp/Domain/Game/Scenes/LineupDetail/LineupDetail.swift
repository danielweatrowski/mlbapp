//
//  LineupDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

enum LineupDetail {
    
    struct GameLineups {
        var home: [Boxscore.Batter]?
        var away: [Boxscore.Batter]?
    }
    
    struct Output {
        let lineups: GameLineups
    }
    
    class ViewModel: ObservableObject {
        let navigationTitle = "Lineups"
        
        @Published var homeLineup: [String] = []
        @Published var awayLineup: [String] = []

    }
    
}
