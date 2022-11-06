//
//  SearchGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation
import Combine

// TODO:
// - Custom errors with combine

protocol SearchGameBusinessLogic {
    func createSearchGame(request: LookupGame.LookupGame.Request)
}

protocol SearchGameDataStore {
    
}

class SearchGameInteractor: SearchGameBusinessLogic {
    
    var presenter: LookupGamePresentationLogic?
    private var worker: LookupGameWorker = LookupGameWorker()
    private var cancellable: AnyCancellable?
    
    init() {
        // subscribe to worker publisher to receive the lookup results
        subscribeToWorker()
    }
    
    func subscribeToWorker() {
        cancellable = worker.publisher.sink { completion in
            switch(completion) {
            case .failure(let error):
                print(error)
            case .finished:
                break
            }
        } receiveValue: { [weak self] games in
            if games.isEmpty {
                self?.presenter?.presentLookupError(error: .noGamesFound)
            } else {
                let response = LookupGame.LookupGame.Response(results: games)
                self?.presenter?.presentLookupGames(response: response)
            }
        }
    }
    
    func createSearchGame(request: LookupGame.LookupGame.Request) {
        
        if request.homeTeamIndex == .max {
            presenter?.presentLookupError(error: .missingTeamID)
            return
        }
        
        worker.lookupGames(for: request)
    }
    
}
