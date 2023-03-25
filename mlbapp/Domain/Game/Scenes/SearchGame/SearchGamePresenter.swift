//
//  SearchGamePresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation

protocol SearchGamePresentationLogic {
    func presentLookupGames(response: SearchGame.Response)
}

struct SearchGamePresenter: SearchGamePresentationLogic {
    
    let viewModel: SearchGame.ViewModel
    
    func presentLookupGames(response: SearchGame.Response) {
        let gameResults = response.results
        
        DispatchQueue.main.async {
            viewModel.searchResults = gameResults
        }
    }
    
    // TODO: Present Error
}
