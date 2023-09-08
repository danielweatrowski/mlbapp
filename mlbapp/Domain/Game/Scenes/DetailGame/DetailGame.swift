//
//  DetailGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation
import Common
import Models
import Views

enum DetailGame {
    
    enum State {
        case loading, loaded(sections: [Section]), error
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
        @Published var currentPlayViewModel: CurrentPlayViewModel?
        @Published var infoItems: [GameInfoItem] = []
        
        @Published var winnerViewModel: GameDetailPitcherViewModel?
        @Published var loserViewModel: GameDetailPitcherViewModel?
        @Published var saverViewModel: GameDetailPitcherViewModel?
        
        @Published var probableHomeStarter: GameDetailPitcherViewModel?
        @Published var probableAwayStarter: GameDetailPitcherViewModel?
        
        @Published var previewHeaderViewModel: PreviewHeaderViewModel?
        //@Published var sections: [Section] = []

        // errors
        @Published var sceneError: SceneError = SceneError()
        
        
        init(gameID: Int) {
            self.gameID = gameID
        }
        
        var isGameLiveOrFinal: Bool {
            return gameStatus == .final || gameStatus == .live
        }
    }
    
    struct GameInfoItem: Hashable {
        
        enum InfoType: CaseIterable {
            case date, firstPitchTime, duration, attendance, weather, wind, venue
            
            var title: String {
                switch(self) {
                case .date: return "Scheduled"
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

// MARK: Layout
extension DetailGame {
    
    enum Section: String, CaseIterable, Hashable {
        case previewHeader
        case header
        case probablePitchers
        case decisions
        case gameInfo
        case teamInfo
        case about
        case currentPlay
        
    }
    
    enum Layout {
        static var previewLayout: [Section] = [
            .previewHeader,
            .probablePitchers,
            .teamInfo,
            .about
        ]
        
        static var liveLayout: [Section] = [
            .header,
            .currentPlay,
            .gameInfo,
            .teamInfo,
            .about
        ]
        
        static var finalLayout: [Section] = [
            .header,
            .decisions,
            .gameInfo,
            .teamInfo,
            .about
        ]
    }
}
