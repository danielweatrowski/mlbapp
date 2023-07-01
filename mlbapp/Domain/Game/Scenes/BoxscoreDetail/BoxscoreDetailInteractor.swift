//
//  BoxscoreInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

protocol BoxscoreDetailBusinessLogic {
    func loadBoxscore()
}

protocol BoxscoreDetailDataStore  {
    var gameID: Int { get set }
}

struct BoxscoreDetailInteractor: BoxscoreDetailBusinessLogic & BoxscoreDetailDataStore {
    
    let presenter: BoxscoreDetailPresentationLogic?
    var gameWorker = GameWorker(store: MLBAPIRepository())
    var gameID: Int
    
    func loadBoxscore() {
        Task {
            do {
                let boxscore = try await gameWorker.fetchBoxscore(forGameID: gameID)
                let output = BoxscoreDetail.Output(boxscore: boxscore)
                
                presenter?.presentBoxscore(output: output)
            } catch {
                let sceneError = SceneError(errorDescription: error.localizedDescription)
                self.presenter?.presentSceneError(sceneError)
            }
        }
    }
}
