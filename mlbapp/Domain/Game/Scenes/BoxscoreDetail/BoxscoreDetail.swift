//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

enum BoxscoreDetail {
    
    class ViewModel: ObservableObject {
        
        enum State {
            case loading, loaded, error
        }
        
        var gameID: Int
        var formattedGameDate: String
        
        var homeTeamAbbreviation: String
        var awayTeamAbbreviation: String

        var navigationTitle: String = "Boxscore"
        @Published var state: State = .loading
        
        @Published var boxscoreViewModel: BoxscoreGridViewModel?
        @Published var pitchingBoxscoreViewModel: BoxscoreGridViewModel?
        
        @Published var homeTeamBattingDetails: [Boxscore.GameDetail]?
        @Published var awayTeamBattingDetails: [Boxscore.GameDetail]?
        @Published var homeTeamFieldingDetails: [Boxscore.GameDetail]?
        @Published var awayTeamFieldingDetails: [Boxscore.GameDetail]?
        @Published var homeTeamRunningDetails: [Boxscore.GameDetail]?
        @Published var awayTeamRunningDetails: [Boxscore.GameDetail]?
        
        init(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, navigationTitle: String = "Boxscore", boxscoreViewModel: BoxscoreGridViewModel? = nil, pitchingBoxscoreViewModel: BoxscoreGridViewModel? = nil, homeTeamBattingDetails: [Boxscore.GameDetail]? = nil, awayTeamBattingDetails: [Boxscore.GameDetail]? = nil, homeTeamFieldingDetails: [Boxscore.GameDetail]? = nil, awayTeamFieldingDetails: [Boxscore.GameDetail]? = nil, homeTeamRunningDetails: [Boxscore.GameDetail]? = nil, awayTeamRunningDetails: [Boxscore.GameDetail]? = nil) {
            self.gameID = gameID
            self.formattedGameDate = formattedGameDate
            self.homeTeamAbbreviation = homeTeamAbbreviation
            self.awayTeamAbbreviation = awayTeamAbbreviation
            self.navigationTitle = navigationTitle
            self.boxscoreViewModel = boxscoreViewModel
            self.pitchingBoxscoreViewModel = pitchingBoxscoreViewModel
            self.homeTeamBattingDetails = homeTeamBattingDetails
            self.awayTeamBattingDetails = awayTeamBattingDetails
            self.homeTeamFieldingDetails = homeTeamFieldingDetails
            self.awayTeamFieldingDetails = awayTeamFieldingDetails
            self.homeTeamRunningDetails = homeTeamRunningDetails
            self.awayTeamRunningDetails = awayTeamRunningDetails
        }
    }
    
    struct Output {
        let boxscore: Boxscore
    }
}
