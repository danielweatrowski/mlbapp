//
//  SearchGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation
import Combine

protocol SearchGameBusinessLogic {
    func createSearchGame(request: LookupGame.LookupGame.Request)
}

protocol SearchGameDataStore {
    var lookupResults: [MLBGame] { get set }
}

class SearchGameInteractor: SearchGameBusinessLogic, SearchGameDataStore {
    
    var presenter: LookupGamePresentationLogic?
    private var worker: LookupGameWorker = LookupGameWorker()
    private var cancellable: AnyCancellable?
    
    // Data store
    var lookupResults: [MLBGame] = []
    
    @MainActor
    func createSearchGame(request: LookupGame.LookupGame.Request) {
        
        if request.homeTeamIndex == .max {
            presenter?.presentLookupError(error: .missingTeamID)
            return
        }
        
        Task {
            do {
                let games = try await worker.lookupGames(for: request)
                
                guard games.isEmpty == false else {
                    presenter?.presentLookupError(error: .noGamesFound)
                    return
                }
                
                // present games
                let response = LookupGame.LookupGame.Response(results: games)
                presenter?.presentLookupGames(response: response)
                lookupResults = games
            } catch let error {
                presenter?.presentLookupError(error: .unknown(error.localizedDescription))
            }
        }
    }
}
