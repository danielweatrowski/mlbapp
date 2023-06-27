//
//  DetailGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation

enum DetailGame {
    
    enum State {
        case loading, loaded, error
    }
    
    class ViewModel: ObservableObject {
        var gameID: Int
        
        @Published var state: State = .loading
        @Published var navigationTitle: String = ""
        @Published var gameDate: String = ""
        @Published var gameStatus: GameStatus = .other
        @Published var homeTeamAbbreviation: String = ""
        @Published var awayTeamAbbreviation: String = ""
        @Published var headerViewModel: DetailGameHeaderViewModel?
        @Published var lineScoreViewModel: LinescoreGridViewModel?
        @Published var decisionsViewModel: DecisionsInfoViewModel?
        @Published var probablePitchersViewModel: ProbablePitchersViewModel?
        @Published var currentPlayViewModel: CurrentPlayViewModel?
        @Published var infoItems: [GameInfoItem] = []
        
        
        init(gameID: Int) {
            self.gameID = gameID
        }
        
        var showProbablePitchers: Bool {
            return probablePitchersViewModel != nil && gameStatus == .preview
        }
        
        var showDecisions: Bool {
            return decisionsViewModel != nil
        }
        
        var isGameLiveOrFinal: Bool {
            return gameStatus == .final || gameStatus == .live
        }
    }
    
    struct GameInfoItem: Hashable {
        
        enum InfoType: CaseIterable {
            case firstPitchTime, duration, attendance, weather, wind, venue
            
            var title: String {
                switch(self) {
                case .firstPitchTime: return "First Pitch"
                case .venue: return "Venue"
                case .duration: return "Duration"
                case .attendance: return "Attendance"
                case .weather: return "Weather"
                case .wind: return "Wind"
                }
            }
        }
        
        let type: InfoType
        let value: String
    }

    enum DetailGame {
        struct Response {
            var game: Game
        }
    }
}
