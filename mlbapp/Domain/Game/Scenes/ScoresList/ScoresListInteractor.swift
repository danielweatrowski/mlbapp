//
//  ScoresListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import Foundation


protocol ScoresListBusinessLogic {
    func loadScores(for date: Date)
    func getNextDay(from date: Date?) -> Date
    func getPreviousDay(from date: Date?) -> Date
}

class ScoresListInteractor: ObservableObject, ScoresListBusinessLogic {
    
    let presenter: ScoresListPresentationLogic?
    
    private let gameWorker = GameWorker(store: MLBAPIRepository())
    
    init(presenter: ScoresListPresentationLogic?) {
        self.presenter = presenter
    }
    
    func loadScores(for date: Date) {
        
        Task {
            do {
                let lookupResults = try await gameWorker.searchGame(with: .init(homeTeamID: nil,
                                                                                awayTeamID: nil,
                                                                                startDate: date,
                                                                                endDate: date))
                
                let sortedResults = sort(results: lookupResults)
                let output = ScoresList.Output(results: sortedResults)
                presenter?.presentScoresList(output: output)
            } catch {
                let sceneError = SceneError(errorDescription: error.localizedDescription)
                presenter?.presentSceneError(sceneError)
            }
        }
    }
    
    func getNextDay(from date: Date?) -> Date {
        guard let date = date else {
            return Date()
        }
        return Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    
    func getPreviousDay(from date: Date?) -> Date {
        guard let date = date else {
            return Date()
        }
        
        return Calendar.current.date(byAdding: .day, value: -1, to: date)!
    }
    
}

// Private methods
extension ScoresListInteractor {
    func sort(results: [GameSearch.Result]) -> [GameSearch.Result] {
        var liveGames = results.filter({ $0.status == .live })
        var finalGames = results.filter({ $0.status == .final })
        var elseGames = results.filter({ $0.status == .preview  || $0.status == .other})
        
        liveGames.sort(by: { $0.gameDate < $1.gameDate })
        finalGames.sort(by: { $0.gameDate < $1.gameDate })
        elseGames.sort(by: { $0.gameDate < $1.gameDate })

        return liveGames + elseGames + finalGames
    }
}
