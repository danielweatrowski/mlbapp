//
//  Router.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/19/23.
//

import Foundation
import SwiftUI

enum RouterDestination: Hashable {
    case empty
    case gameList(results: [GameSearch.Result])
    case searchGame
    case gameDetail(gameID: Int)
    case boxscore(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, players: [Int: Player])
    case summaryGame(gameID: Int)
    case lineupDetail(gameID: Int, boxscore: Boxscore?)
    case rosterDetail(homeTeam: Team?, awayTeam: Team?, gameDate: Date?)
}

@MainActor
class Router: ObservableObject {
    @Published public var path: [RouterDestination] = []
    
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
            case let .boxscore(id, date, homeAbbr, awayAbbr, players):
                BoxscoreDetailView.configure(gameID: id, formattedGameDate: date, homeTeamAbbreviation: homeAbbr, awayTeamAbbreviation: awayAbbr, players: players)
            case let .summaryGame(gameID: gameID):
                SummaryGameView.configure(gameID: gameID)
            case let .lineupDetail(gameID: gameID, boxscore: boxscore):
                LineupDetailView.configure(gameID: gameID, boxscore: boxscore)
            case let .rosterDetail(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate):
                RosterDetailView.configure(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate)
            case .empty:
                EmptyView()
            }
        }
    }
}
