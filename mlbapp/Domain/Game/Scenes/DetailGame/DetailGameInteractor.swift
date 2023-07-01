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
    var playerHash: [Int: Player]? { get }
    var boxscore: Boxscore? { get }
}

class DetailGameInteractor: DetailGameBusinessLogic & DetailGameDataStore, ObservableObject {
    
    var presenter: DetailGamePresentationLogic
    var gameWorker = GameWorker(store: MLBAPIRepository())
    var gameID: Int
    
    var playerHash: [Int: Player]? = nil
    var boxscore: Boxscore? = nil
    
    init(gameID: Int, presenter: DetailGamePresentationLogic) {
        self.gameID = gameID
        self.presenter = presenter
    }
    
    func loadGame() {
        Task {
            do {
                let game = try await gameWorker.fetchGame(withID: gameID)
                let response = DetailGame.DetailGame.Response(game: game)
                
                self.playerHash = game.players
                self.boxscore = game.boxscore
                
                
                presenter.presentGame(response: response)
            } catch {
                let sceneError = SceneError(errorDescription: error.localizedDescription)
                self.presenter.presentSceneError(sceneError)
            }
        }
    }
}
