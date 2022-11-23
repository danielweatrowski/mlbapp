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
            var game: MLBGame
        }
        
        struct ViewModel {
            struct DetailGameHeader {
                
                var homeTeam: MLBTeam = .any
                var homeTeamScore: String = ""
                var homeTeamRecord: String = ""
                var awayTeam: MLBTeam = .any
                var awayTeamScore: String = ""
                var awayTeamRecord: String = ""
                
            }
            
            struct InfoViewModel {
                var gameDate: String = ""
                var venueName: String = ""
            }
            
            var headerViewModel: DetailGameHeader
            var infoViewModel: InfoViewModel
            
        }
    }
}
