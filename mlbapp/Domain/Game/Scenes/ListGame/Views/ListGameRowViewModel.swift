//
//  ListGameRowViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/4/23.
//

import Foundation

struct ListGameRowViewModel {
    let id = UUID()
    let gameID: Int
    let gameStatus: GameStatus
    let gameVenueName: String
    let homeTeamID: Int
    let homeTeamName: String
    let homeTeamAbbreviation: String
    let homeTeamScore: String
    let homeTeamRecord: String
    let homeTeamLogoName: String
    let awayTeamID: Int
    let awayTeamName: String
    let awayTeamAbbreviation: String
    let awayTeamScore: String
    let awayTeamRecord: String
    let awayTeamLogoName: String
    let winningPitcherName: String?
    let losingPitcherName: String?
    let savePitcherName: String?
    
    let linescoreViewModel: LinescoreGridViewModel?
    let statusBannerViewModel: StatusBannerViewModel?
    
    var awayTeamDidWin: Bool {
        return awayTeamScore > homeTeamScore
    }
    
    var homeTeamDidWin: Bool {
        return awayTeamScore < homeTeamScore
    }
    
    var showLinescore: Bool {
        return (linescoreViewModel != nil && isGameLiveOrFinal)
    }
    
    var isGameLiveOrFinal: Bool {
        return gameStatus == .final || gameStatus == .live
    }
    
    var isGameLive: Bool {
        return gameStatus == .live
    }
    
    var isGameScheduled: Bool {
        return gameStatus == .preview
    }
    
    var showDecisions: Bool {
        winningPitcherName != nil && losingPitcherName != nil
    }
    
    var isGameFinal: Bool {
        return gameStatus == .final
    }
}
