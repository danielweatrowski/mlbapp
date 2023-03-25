//
//  Router.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/19/23.
//

import Foundation
import SwiftUI

enum RouterDestination: Hashable {
    case gameList(results: [GameSearch.Result])
    case searchGame
    case gameDetail(gameID: Int)
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
            }
        }
    }
}
