//
//  ListGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

protocol ListGameRoutingLogic {
    func routeToDetailGame(gameID: Int) -> DetailGameView
}

class ListGameRouter: ObservableObject, ListGameRoutingLogic {
    
    func routeToDetailGame(gameID: Int) -> DetailGameView {
        return DetailGameConfigurator.configure(for: gameID)
    }
}
