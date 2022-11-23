//
//  SearchGameRouter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import SwiftUI

protocol LookupGameRoutingLogic {
    func routeToListGame(viewModel: ListGame.ListGameLookupResults.ViewModel)
    func showErrorAlert(error: LookupGame.LookupGameError)
}

protocol LookupGameDataPassing {
    var dataStore: SearchGameDataStore? { get }
}

class LookupGameRouter: ObservableObject, LookupGameRoutingLogic, LookupGameDataPassing {
    
    var dataStore: SearchGameDataStore?
    
    @Published var routingToListGame = false
    @Published var showingErrorAlert = false
    
    // MARK: - Destinations
    var listGameDestination: ListGameView?
    var errorAlertTitle: String?

    func routeToListGame(viewModel: ListGame.ListGameLookupResults.ViewModel) {
        
        let interactor = ListGameInteractor(lookupResults: dataStore?.lookupResults ?? [])
        listGameDestination = ListGameView(viewModel: viewModel, interactor: interactor, router: ListGameRouter())
        
        routingToListGame = true
    }
    
    func showErrorAlert(error: LookupGame.LookupGameError) {
        errorAlertTitle = error.description
        
        DispatchQueue.main.async {
            self.showingErrorAlert = true
        }
    }
}
