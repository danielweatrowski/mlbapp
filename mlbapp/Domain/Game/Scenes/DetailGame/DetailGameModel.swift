//
//  DetailGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

enum DetailGame {

    enum DetailGame {
        struct Response {
            var game: Game
            var linescore: MLBLinescore
        }
        
        struct ViewModel {
            struct DetailGameHeader {
                
                var homeTeam: Team = .any
                var homeTeamScore: String = ""
                var homeTeamRecord: String = ""
                var awayTeam: Team = .any
                var awayTeamScore: String = ""
                var awayTeamRecord: String = ""
                
            }
            
            struct InfoViewModel {
                var gameDate: String = ""
                var venueName: String = ""
            }
            
            var headerViewModel: DetailGameHeader
            var infoViewModel: InfoViewModel
            var lineScoreViewModel: LineScoreViewModel
        }
    }
}
