//
//  DetailGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import Foundation
import Combine

protocol DetailGameBusinessLogic {
    func getViewModel()
    func startGame()
}

protocol DetailGameDataStore  {
    var game: Game { get set }
}

struct DetailGameInteractor: DetailGameBusinessLogic & DetailGameDataStore {
    
    var presenter: DetailGamePresentationLogic
    var game: Game
    
    func getViewModel() {
        
        Task {
            do {
                let gameDTO = try await SwiftMLB.game(gameIdentifier: game.id)
                
                let response = DetailGame.DetailGame.Response(game: game, linescore: gameDTO.linescore)
                presenter.presentGame(response: response)
            } catch {
                print(error)
            }

        }
    }
    
    func startGame() {
        Task {
            do {
                let parameters = SwiftMLBRequest.PersonParameters(personIdentifier: 571448, hydrate: .init(group: [.pitching, .hitting, .fielding], type: [.career]))
                let data = try await SwiftMLB.boxscore(gameIdentifier: 565997)
                print("SHIT")
            } catch let error {
                print(error)
            }
        }
    }
}
