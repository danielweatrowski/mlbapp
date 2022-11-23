//
//  ListGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

protocol ListGameRoutingLogic {
    func routeToDetailGame(game: MLBGame) -> DetailGameView<DetailGameInteractor>
}

protocol ListGameDataPassing {
    var dataStore: ListGameDataStore? { get }
}

class ListGameRouter: ObservableObject, ListGameRoutingLogic {
    
    func routeToDetailGame(game: MLBGame) -> DetailGameView<DetailGameInteractor> {
        let presenter = DetailGamePresenter()
        let interactor = DetailGameInteractor()
        let view = DetailGameView(interactor: interactor)

        interactor.game = game
        //interactor.title = game.abbreviation
        interactor.presenter = presenter
        presenter.view = view
        
        return view
        
    }

    
}
