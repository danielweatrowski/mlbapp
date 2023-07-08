//
//  StandingsListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation


protocol StandingsListBusinessLogic {
    func loadStandings() async
}

protocol StandingsListDataStore {

}

struct StandingsListInteractor: StandingsListBusinessLogic & StandingsListDataStore {
    
    let presenter: StandingsListPresentationLogic
    let standingsWorker = StandingsWorker(store: MLBAPIRepository())
    
    func loadStandings() async {
        
        do {
            let standings = try await standingsWorker.fetchStandings(for: Date())
            let output = StandingsList.Output(nationalLeagueStandings: standings.nationalLeagueRecords,
                                              americanLeagueStandings: standings.americanLeagueRecords)
            
            presenter.presentStandingsList(output: output)
        } catch {
            let sceneError = SceneError(errorDescription: error.localizedDescription)
            presenter.presentSceneError(sceneError)
        }
    }
}
