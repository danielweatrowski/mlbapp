//
//  SearchGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/25/22.
//

import Foundation
import Combine

protocol SearchGameBusinessLogic {
    func createSearchGame(request: SearchGame.Request)
}

protocol SearchGameDataStore {
    var lookupResults: [GameSearch.Result] { get set }
}

class SearchGameInteractor: SearchGameBusinessLogic, SearchGameDataStore {
    
    var presenter: SearchGamePresentationLogic
    var gameWorker = GameWorker(store: MLBAPIRepository())

    private var cancellable: AnyCancellable?
    
    // Data store
    var lookupResults: [GameSearch.Result] = []
    
    init(presenter: SearchGamePresentationLogic) {
        self.presenter = presenter
    }
    
    @MainActor
    func createSearchGame(request: SearchGame.Request) {
        
        guard let homeTeamID = request.homeTeamID else {
            presenter.presentLookupError(error: .missingTeamID)
            return
        }
        
        Task {
            do {
                let parameters = GameSearch.SearchParameters(homeTeamID: homeTeamID,
                                                             awayTeamID: request.awayTeamID,
                                                             startDate: request.startDate,
                                                             endDate: request.endDate)
                
                let lookupResults = try await gameWorker.searchGame(with: parameters)
                
                guard lookupResults.isEmpty == false else {
                    presenter.presentLookupError(error: .noGamesFound)
                    return
                }
                
                // present games
                let response = SearchGame.Response(results: lookupResults)
                presenter.presentLookupGames(response: response)
                self.lookupResults = lookupResults
            } catch {
                print(error.localizedDescription)
                presenter.presentLookupError(error: .unknown(error.localizedDescription))
            }
        }
    }
}
