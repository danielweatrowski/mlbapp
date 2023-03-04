//
//  DetailGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation
import Combine

protocol DetailGameBusinessLogic {
    func loadGame()
}

protocol DetailGameDataStore  {
    var gameID: Int { get set }
}

struct DetailGameInteractor: DetailGameBusinessLogic & DetailGameDataStore {
    
    var presenter: DetailGamePresentationLogic
    var gameWorker = GameWorker(store: MLBAPIService())
    var gameID: Int
    
    func loadGame() {
        Task {
            do {
                let game = try await gameWorker.fetchGame(withID: gameID)
                let response = DetailGame.DetailGame.Response(game: game)
                presenter.presentGame(response: response)
            } catch {
                print(error)
            }
        }
    }
}
