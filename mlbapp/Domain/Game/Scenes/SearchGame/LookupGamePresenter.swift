//
//  SearchGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation

protocol LookupGamePresentationLogic {
    func presentLookupGames(response: LookupGame.LookupGame.Response)
    func presentLookupError(error: LookupGame.LookupGameError)
}

class SearchGamePresenter: LookupGamePresentationLogic {
    
    var view: SearchGameDisplayLogic?
    
    func presentLookupGames(response: LookupGame.LookupGame.Response) {
        let viewModel = LookupGame.LookupGame.ViewModel(results: response.results)
        
        DispatchQueue.main.async {
            self.view?.displayLookupResults(viewModel: viewModel)
        }
    }
    
    func presentLookupError(error: LookupGame.LookupGameError) {
        view?.displayLookupError(error: error)
    }

}
