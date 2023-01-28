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
        
        let viewModel = DetailGame.ViewModel(navigationTitle: game.abbreviation)
        let presenter = DetailGamePresenter(viewModel: viewModel)
        let interactor = DetailGameInteractor(presenter: presenter, game: game)
        let view = DetailGameView(interactor: interactor, viewModel: viewModel)
        
        return view
    }

    
}
