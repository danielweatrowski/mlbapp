//
//  LineupDetailInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import Foundation

protocol LineupDetailBusinessLogic {
    func getLineups()
}

protocol LineupDetailDataStore  {
    var gameID: Int { get set }
    var boxscore: Boxscore_V2? { get set }
}

struct LineupDetailInteractor: LineupDetailBusinessLogic, LineupDetailDataStore {

    var gameID: Int
    var boxscore: Boxscore_V2?
    
    let presenter: LineupDetailPresentationLogic?
    
    func getLineups() {
        if let boxscore = boxscore {
            let lineups = LineupDetail.GameLineups(home: boxscore.home.startingLineup,
                                                   away: boxscore.away.startingLineup)
            
            let output = LineupDetail.Output(lineups: lineups)
            presenter?.presentLineups(output: output)
        } else {
            let sceneError = SceneError(errorDescription: "Did fail to unwrap boxscore")
            presenter?.presentSceneError(sceneError)
        }
    }
}
