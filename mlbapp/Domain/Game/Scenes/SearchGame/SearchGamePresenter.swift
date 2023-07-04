//
//  SearchGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation

protocol SearchGamePresentationLogic {
    func presentLookupGames(response: SearchGame.Response)
    func presentLookupError(error: SearchGame.LookupGameError)
}

struct SearchGamePresenter: SearchGamePresentationLogic {
    
    let viewModel: SearchGame.ViewModel
    
    func presentLookupGames(response: SearchGame.Response) {
        let gameResults = response.results
        
        DispatchQueue.main.async {
            viewModel.searchResults = gameResults
        }
    }
    
    @MainActor
    func presentLookupError(error: SearchGame.LookupGameError) {
        viewModel.errorMessage = error.description
        viewModel.didError = true
    }
}
