//
//  ListGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

enum ListGame {
    
    struct ViewModel {
        var rows: [ListGameRowViewModel]
    }
    
    enum ListGameLookupResults {
        struct ViewModel {
            var games: [Game]
        }
    }
    
    enum GameLookupItem {
        struct ViewModel {
            var game: Game
        }
    }
}
