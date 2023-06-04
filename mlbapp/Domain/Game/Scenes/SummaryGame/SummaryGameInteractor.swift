//
//  SummaryGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

protocol SummaryGameBusinessLogic {
    func loadGameSummary()
}

protocol SummaryGameDataStore  {
    var gameID: Int { get set }
}

struct SummaryGameInteractor: SummaryGameBusinessLogic & SummaryGameDataStore {
    
    let presenter: SummaryGamePresentationLogic?
    var gameWorker = GameWorker(store: MLBAPIRepository())
    var gameID: Int
    
    func loadGameSummary() {
        Task {
            do {
                let plays = try await gameWorker.fetchAllPlays(forGameID: gameID)
                let output = SummaryGame.Output(plays: plays)
                
                presenter?.presentGameSummary(output: output)
            } catch {
                print(error)
            }
        }
    }
    
}
