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
    var game: MLBGame? { get set }
    var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader { get set }
    var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel { get set }
    var lineScoreViewModel: LineScoreViewModel { get set }
}

extension DetailGameDataStore {
    var game: MLBGame? {
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

    var game: MLBGame?
    
    @Published var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader = DetailGame.DetailGame.ViewModel.DetailGameHeader()
    @Published var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel = DetailGame.DetailGame.ViewModel.InfoViewModel()
    @Published var lineScoreViewModel: LineScoreViewModel = LineScoreViewModel(headers: LineScoreViewModel.empty,
                                                                               homeLineItems: LineScoreViewModel.empty,
                                                                               awayLineItems: LineScoreViewModel.empty)
    
    init(game: MLBGame? = nil) {
        self.game = game
    }
    
    func getViewModel() {
        
        guard let game = game else {
            return
        }
        
        Task {
            let linescore = try await SwiftMLB.gameDetail(forGameIdentifier: game.id)
            
            let response = DetailGame.DetailGame.Response(game: game, linescore: linescore)
            presenter?.presentGame(response: response)
        }
    }
    
    func startGame() {
        Task {
            do {
                let parameters = SwiftMLBRequest.PersonParameters(personIdentifier: 571448, hydrate: .init(group: [.pitching, .hitting, .fielding], type: [.career]))
                let data = try await SwiftMLB.boxscoreData(gameIdentifier: 565997)
                data.printPretty()
            } catch let error {
                print(error)
            }
        }
    }
}
