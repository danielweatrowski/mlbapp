//
//  ListGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation
import Models

protocol ListGameBusinessLogic {
    func loadGames()
}

protocol ListGameDataStore {
    var games: [GameSearch.Result] { get set }
}

struct ListGameInteractor: ListGameBusinessLogic, ListGameDataStore {
    
    var presenter: ListGamePresenter
    var games: [GameSearch.Result]
    
    func loadGames() {
        let response = ListGame.Response(results: games)
        presenter.presentLookupGames(response: response)
    }
}
