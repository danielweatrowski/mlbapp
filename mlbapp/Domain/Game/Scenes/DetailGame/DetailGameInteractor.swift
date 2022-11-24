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
}

protocol DetailGameDataStore: ObservableObject  {
    var game: MLBGame? { get set }
    var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader { get set }
    var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel { get set }
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
}

class DetailGameInteractor: DetailGameBusinessLogic & DetailGameDataStore {
    var presenter: DetailGamePresentationLogic?

    var game: MLBGame?
    
    @Published var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader = DetailGame.DetailGame.ViewModel.DetailGameHeader()
    @Published var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel = DetailGame.DetailGame.ViewModel.InfoViewModel()

    
    func getViewModel() {
        
        guard let game = game else {
            return
        }
        let response = DetailGame.DetailGame.Response(game: game)
        presenter?.presentGame(response: response)
    }
}