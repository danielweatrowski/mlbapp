//
//  ListGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

enum ListGame {
    enum ListGameLookupResults {
        struct ViewModel {
            var games: [MLBGame]
        }
    }
    
    enum GameLookupItem {
        struct ViewModel {
            var game: MLBGame
        }
    }
}
