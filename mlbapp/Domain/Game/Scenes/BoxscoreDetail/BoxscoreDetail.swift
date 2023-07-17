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
        
        @Published var battingBoxscoreViewModel: BoxscoreGridViewModel?
        @Published var pitchingBoxscoreViewModel: BoxscoreGridViewModel?
        
        @Published var homeTeamBattingDetails: [Boxscore_V2.ListItem]?
        @Published var awayTeamBattingDetails: [Boxscore_V2.ListItem]?
        @Published var homeTeamFieldingDetails: [Boxscore_V2.ListItem]?
        @Published var awayTeamFieldingDetails: [Boxscore_V2.ListItem]?
        @Published var homeTeamRunningDetails: [Boxscore_V2.ListItem]?
        @Published var awayTeamRunningDetails: [Boxscore_V2.ListItem]?
        
        // error
        @Published var sceneError: SceneError = SceneError()
        
        internal init(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, navigationTitle: String = "Boxscore", state: BoxscoreDetail.ViewModel.State = .loading, boxscoreViewModel: BoxscoreGridViewModel? = nil, pitchingBoxscoreViewModel: BoxscoreGridViewModel? = nil, homeTeamBattingDetails: [Boxscore_V2.ListItem]? = nil, awayTeamBattingDetails: [Boxscore_V2.ListItem]? = nil, homeTeamFieldingDetails: [Boxscore_V2.ListItem]? = nil, awayTeamFieldingDetails: [Boxscore_V2.ListItem]? = nil, homeTeamRunningDetails: [Boxscore_V2.ListItem]? = nil, awayTeamRunningDetails: [Boxscore_V2.ListItem]? = nil, sceneError: SceneError = SceneError()) {
            self.gameID = gameID
            self.formattedGameDate = formattedGameDate
            self.homeTeamAbbreviation = homeTeamAbbreviation
            self.awayTeamAbbreviation = awayTeamAbbreviation
            self.navigationTitle = navigationTitle
            self.state = state
            self.battingBoxscoreViewModel = boxscoreViewModel
            self.pitchingBoxscoreViewModel = pitchingBoxscoreViewModel
            self.homeTeamBattingDetails = homeTeamBattingDetails
            self.awayTeamBattingDetails = awayTeamBattingDetails
            self.homeTeamFieldingDetails = homeTeamFieldingDetails
            self.awayTeamFieldingDetails = awayTeamFieldingDetails
            self.homeTeamRunningDetails = homeTeamRunningDetails
            self.awayTeamRunningDetails = awayTeamRunningDetails
            self.sceneError = sceneError
        }
    }
    
    struct Output {
        let boxscore: Boxscore_V2
    }
}
