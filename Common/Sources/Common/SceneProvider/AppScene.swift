//
//  Scene.swift
//  
//
//  Created by Daniel Weatrowski on 8/14/23.
//

import Foundation
import Models

public enum AppScene: Hashable, Identifiable {
    case empty
    case gameDetail(gameID: Int)
    case boxscore(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, boxscore: Boxscore_V2?, players: [Int: Player])
    case summaryGame(gameID: Int, homeTeamName: String, awayTeamName: String)
    case lineupDetail(gameID: Int, boxscore: Boxscore_V2?)
    case rosterDetail(homeTeam: Team?, awayTeam: Team?, gameDate: Date?)
    case videosList(_ gameID: Int)
    case teamStandingDetail(_ standing: Standings.TeamRecord)
    case videoPlayer(_ url: URL)
    
    public var id: String {
        switch self {
        case .empty:
            return "empty"
        case .gameDetail:
            return "gameDetail"
        case .boxscore:
            return "boxscoreDetail"
        case .summaryGame:
            return "summaryDetail"
        case .lineupDetail:
            return "lineupDetail"
        case .rosterDetail:
            return "rosterDetail"
        case .videosList:
            return "videosList"
        case .teamStandingDetail:
            return "standingDetail"
        case .videoPlayer:
            return "videoPlayer"
        }
    }
}
