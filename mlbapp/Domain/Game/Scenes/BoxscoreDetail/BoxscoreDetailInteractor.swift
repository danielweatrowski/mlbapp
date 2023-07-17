//
//  BoxscoreInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

protocol BoxscoreDetailBusinessLogic {
    func loadBoxscore() async
}

protocol BoxscoreDetailDataStore  {
    var gameID: Int { get set }
    var boxscore: Boxscore_V2? { get }
}

struct BoxscoreDetailInteractor: BoxscoreDetailBusinessLogic & BoxscoreDetailDataStore {
    
    let presenter: BoxscoreDetailPresentationLogic?
    var gameWorker = GameWorker(store: MLBAPIRepository())
    var gameID: Int
    var boxscore: Boxscore_V2?
    
    func loadBoxscore() async {
        
        if let boxscore = boxscore {
            let output = BoxscoreDetail.Output(boxscore: boxscore)
            presenter?.presentBoxscore(output: output)
        } else {
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
