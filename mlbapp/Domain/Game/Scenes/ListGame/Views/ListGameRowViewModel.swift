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
    let gameDate: String
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
    
    let linescoreViewModel: LinescoreGridViewModel?
    
    var awayTeamDidWin: Bool {
        return awayTeamScore > homeTeamScore
    }
    
    var homeTeamDidWin: Bool {
        return awayTeamScore < homeTeamScore
    }
    
    var showLinescore: Bool {
        return linescoreViewModel != nil
    }
}
