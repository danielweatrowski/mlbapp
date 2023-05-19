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
            case .empty:
                EmptyView()
            }
        }
    }
}
