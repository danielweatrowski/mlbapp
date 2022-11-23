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
    var game: LookupGame.LookupGameResult? { get set }
    var headerViewModel: DetailGame.DetailGame.ViewModel.DetailGameHeader { get set }
    var infoViewModel: DetailGame.DetailGame.ViewModel.InfoViewModel { get set }
    var title: String { get set }
}

extension DetailGameDataStore {
    var game: LookupGame.LookupGameResult? {
        get { return nil }
        set { self.game = newValue }
    }
    
    var title: String {
        get { return "" }
        set { self.title = newValue }
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

    var game: LookupGame.LookupGameResult?
    
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
