//
//  DetailGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

enum DetailGame {
    
    struct HeaderViewModel {
        
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
    
    class ViewModel: ObservableObject {
        
        @Published var navigationTitle: String
        @Published var gameDate: String
        @Published var homeTeamAbbreviation: String
        @Published var awayTeamAbbreviation: String
        @Published var headerViewModel: HeaderViewModel?
        @Published var infoViewModel: InfoViewModel?
        @Published var lineScoreViewModel: LineScoreViewModel?
        @Published var boxscoreViewModel: BoxscoreViewModel?
        
        init(navigationTitle: String, gameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, headerViewModel: HeaderViewModel? = nil, infoViewModel: InfoViewModel? = nil, lineScoreViewModel: LineScoreViewModel? = nil, boxscoreViewModel: BoxscoreViewModel? = nil) {
            self.navigationTitle = navigationTitle
            self.gameDate = gameDate
            self.homeTeamAbbreviation = homeTeamAbbreviation
            self.awayTeamAbbreviation = awayTeamAbbreviation
            self.headerViewModel = headerViewModel
            self.infoViewModel = infoViewModel
            self.lineScoreViewModel = lineScoreViewModel
            self.boxscoreViewModel = boxscoreViewModel
        }
        
    }

    enum DetailGame {
        struct Response {
            var game: Game
            var linescore: MLBLinescore
            var boxscore: MLBBoxscore
        }
    }
}
