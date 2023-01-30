//
//  ListGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

protocol ListGameRoutingLogic {
    func routeToDetailGame(game: Game) -> DetailGameView
}

protocol ListGameDataPassing {
    var dataStore: ListGameDataStore? { get }
}

class ListGameRouter: ObservableObject, ListGameRoutingLogic {
    
    func routeToDetailGame(game: Game) -> DetailGameView {
        return DetailGameConfigurator.configure(for: game)
    }
}
