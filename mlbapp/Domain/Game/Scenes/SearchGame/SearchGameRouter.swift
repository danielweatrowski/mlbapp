//
//  SearchGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import SwiftUI
/*
protocol SearchGameRoutingLogic {
    func routeToListGame(viewModel: ListGame.ViewModel) 
    func showErrorAlert(error: SearchGame.LookupGameError)
}

protocol SearchGameDataPassing {
    var dataStore: SearchGameDataStore? { get }
}

class SearchGameRouter: ObservableObject, SearchGameRoutingLogic, SearchGameDataPassing {
    
    var dataStore: SearchGameDataStore?
    
    @Published var routingToListGame = false
    @Published var showingErrorAlert = false
    
    // MARK: - Destinations
    var listGameDestination: ListGameView?
    var errorAlertTitle: String?

    func routeToListGame(viewModel: ListGame.ViewModel) {
        
        let interactor = ListGameInteractor()
        listGameDestination = ListGameView(viewModel: viewModel, interactor: interactor)
        
        routingToListGame = true
    }
    
    func showErrorAlert(error: SearchGame.LookupGameError) {
        errorAlertTitle = error.description
        
        DispatchQueue.main.async {
            self.showingErrorAlert = true
        }
    }
}
*/
