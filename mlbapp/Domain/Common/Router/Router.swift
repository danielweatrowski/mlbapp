//
//  Router.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/19/23.
//

import Foundation
import SwiftUI
import Models

enum RouterDestination: Hashable {
    case empty
    case gameList(results: [GameSearch.Result])
    case searchGame
    case gameDetail(gameID: Int)
    case boxscore(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, boxscore: Boxscore_V2?, players: [Int: Player])
    case summaryGame(gameID: Int, homeTeamName: String, awayTeamName: String)
    case lineupDetail(gameID: Int, boxscore: Boxscore_V2?)
    case rosterDetail(homeTeam: Team?, awayTeam: Team?, gameDate: Date?)
    case videosList(_ gameID: Int)
}

@MainActor
class Router: ObservableObject {
    
    @Published public var path: [RouterDestination] = []
    @Published public var presentedSheet: Sheet?

    public func navigate(to: RouterDestination) {
      path.append(to)
    }
}


@MainActor
extension View {
    func withRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case let .gameList(results):
                ListGameView.configure(results: results)
            case .searchGame:
                SearchGameView.configure()
            case let .gameDetail(id):
                DetailGameConfigurator.configure(for: id)
            case let .boxscore(id, date, homeAbbr, awayAbbr, boxscore, players):
                BoxscoreDetailView.configure(gameID: id, formattedGameDate: date, homeTeamAbbreviation: homeAbbr, awayTeamAbbreviation: awayAbbr, boxscore: boxscore, players: players)
            case let .summaryGame(gameID: gameID, homeTeamName: homeTeamName, awayTeamName: awayTeamName):
                PlaysListView.configure(gameID: gameID, homeTeamName: homeTeamName, awayTeamName: awayTeamName)
            case let .lineupDetail(gameID: gameID, boxscore: boxscore):
                LineupDetailView.configure(gameID: gameID, boxscore: boxscore)
            case let .rosterDetail(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate):
                RosterDetailView.configure(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate)
            case let .videosList(gameID):
                VideosListView.configure(gameID: gameID)
            case .empty:
                EmptyView()
            }
        }
    }
}
