//
//  ScoresListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import Foundation


protocol ScoresListBusinessLogic {
    func loadScores()
}

class ScoresListInteractor: ScoresListBusinessLogic {
    
    let presenter: ScoresListPresentationLogic?
    
    private let gameWorker = GameWorker(store: MLBAPIRepository())
    
    init(presenter: ScoresListPresentationLogic?) {
        self.presenter = presenter
    }
    
    func loadScores() {
        
        Task {
            do {
                let lookupResults = try await gameWorker.searchGame(with: .init(homeTeamID: nil,
                                                                                awayTeamID: nil,
                                                                                startDate: Date(),
                                                                                endDate: Date()))
                let output = ScoresList.Output(results: lookupResults)
                presenter?.presentScoresList(output: output)
            } catch {
                print(error)
            }
        }
    }
    
}
