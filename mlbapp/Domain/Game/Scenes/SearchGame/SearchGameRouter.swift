//
//  SearchGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import SwiftUI

protocol SearchGameRoutingLogic {
    func routeToListGame(viewModel: ListGame.ListGameLookupResults.ViewModel)
    func showErrorAlert(error: LookupGame.LookupGameError)
}

class SearchGameRouter: ObservableObject, SearchGameRoutingLogic {
    
    @Published var routingToListGame = false
    @Published var showingErrorAlert = false
    
    // MARK: - Destinations
    var listGameDestination: ListGameView?
    var errorAlertTitle: String?

    func routeToListGame(viewModel: ListGame.ListGameLookupResults.ViewModel) {
        let interactor = ListGameInteractor()
        listGameDestination = ListGameView(viewModel: viewModel, interactor: interactor)
        
        routingToListGame = true
    }
    
    func showErrorAlert(error: LookupGame.LookupGameError) {
        errorAlertTitle = error.description
        
        showingErrorAlert = true
    }
}
