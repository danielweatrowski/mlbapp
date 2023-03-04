//
//  SearchGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation
import Combine

protocol SearchGameBusinessLogic {
    func createSearchGame(request: LookupGame.Request)
}

protocol SearchGameDataStore {
    var lookupResults: [LookupGame.Result] { get set }
}

class SearchGameInteractor: SearchGameBusinessLogic, SearchGameDataStore {
    
    var presenter: LookupGamePresentationLogic?
    private var worker: LookupGameWorker = LookupGameWorker()
    private var cancellable: AnyCancellable?
    
    // Data store
    var lookupResults: [LookupGame.Result] = []
    
    @MainActor
    func createSearchGame(request: LookupGame.Request) {
        
        if request.parameters.homeTeamIndex == .max {
            presenter?.presentLookupError(error: .missingTeamID)
            return
        }
        
        Task {
            do {
                let lookupResults = try await worker.lookupGames(for: request)
                
                guard lookupResults.isEmpty == false else {
                    presenter?.presentLookupError(error: .noGamesFound)
                    return
                }
                
                // present games
                let response = LookupGame.Response(results: lookupResults)
                presenter?.presentLookupGames(response: response)
                self.lookupResults = lookupResults
            } catch {
                presenter?.presentLookupError(error: .unknown(error.localizedDescription))
            }
        }
    }
}
