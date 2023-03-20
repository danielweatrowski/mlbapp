//
//  DetailGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

enum DetailGame {
    
    class ViewModel: ObservableObject {
        var gameID: Int
        
        @Published var navigationTitle: String = ""
        @Published var gameDate: String = ""
        @Published var homeTeamAbbreviation: String = ""
        @Published var awayTeamAbbreviation: String = ""
        @Published var headerViewModel: DetailGameHeaderViewModel?
        @Published var lineScoreViewModel: LinescoreGridViewModel?
        @Published var decisionsViewModel: DecisionsInfoViewModel?
        @Published var boxscoreViewModel: BoxscoreViewModel?
        @Published var pitchingBoxscoreViewModel: BoxscoreViewModel?
        @Published var homeTeamBattingDetails: [Boxscore.GameDetail]?
        @Published var awayTeamBattingDetails: [Boxscore.GameDetail]?
        @Published var homeTeamFieldingDetails: [Boxscore.GameDetail]?
        @Published var awayTeamFieldingDetails: [Boxscore.GameDetail]?
        @Published var homeTeamRunningDetails: [Boxscore.GameDetail]?
        @Published var awayTeamRunningDetails: [Boxscore.GameDetail]?
        
        init(gameID: Int) {
            self.gameID = gameID
        }
    }

    enum DetailGame {
        struct Response {
            var game: Game
        }
    }
}
