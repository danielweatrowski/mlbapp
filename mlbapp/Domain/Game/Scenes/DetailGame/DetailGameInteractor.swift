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

protocol DetailGameDataStore: ObservableObject  {
    var game: Game? { get set }
    var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader { get set }
    var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel { get set }
    var lineScoreViewModel: LineScoreViewModel { get set }
}

extension DetailGameDataStore {
    var game: Game? {
        get { return nil }
        set { self.game = newValue }
    }
    
    var title: String {
        get { return game?.abbreviation ?? "" }
    }
    
    var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader {
        get { return DetailGame.DetailGame.ViewModel.DetailGameHeader() }
        set { self.headerViewModel = newValue }
    }
    
    var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel {
        get { return DetailGame.DetailGame.ViewModel.InfoViewModel() }
        set { self.infoViewModel = newValue }
    }
    
    var lineScoreViewModel: LineScoreViewModel {
        get { return LineScoreViewModel(headers: LineScoreViewModel.empty, homeLineItems: LineScoreViewModel.empty, awayLineItems: LineScoreViewModel.empty) }
        set { self.lineScoreViewModel = newValue }
    }
}

class DetailGameInteractor: DetailGameBusinessLogic & DetailGameDataStore {
    var presenter: DetailGamePresentationLogic?

    var game: Game?
    
    @Published var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader = DetailGame.DetailGame.ViewModel.DetailGameHeader()
    @Published var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel = DetailGame.DetailGame.ViewModel.InfoViewModel()
    @Published var lineScoreViewModel: LineScoreViewModel = LineScoreViewModel(headers: LineScoreViewModel.empty,
                                                                               homeLineItems: LineScoreViewModel.empty,
                                                                               awayLineItems: LineScoreViewModel.empty)
    
    init(game: Game? = nil) {
        self.game = game
    }
    
    func getViewModel() {
        
        guard let game = game else {
            return
        }
        
        Task {
            do {
                let gameDTO = try await SwiftMLB.game(gameIdentifier: game.id)
                
                let response = DetailGame.DetailGame.Response(game: game, linescore: gameDTO.linescore)
                presenter?.presentGame(response: response)
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
