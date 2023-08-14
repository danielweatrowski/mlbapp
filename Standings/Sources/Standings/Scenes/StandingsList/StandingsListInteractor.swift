//
//  StandingsListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation
import Models
import Common

protocol StandingsListBusinessLogic {
    func loadStandings() async
    func loadWildcardStandings()
    func loadStanding(forTeam teamID: Int)
}

protocol StandingsListDataStore {
    var nationalLeagueStandings: Standings.LeagueRecord? { get }
    var americanLeagueStandings: Standings.LeagueRecord? { get }
}

class StandingsListInteractor<S: StandingsStoreProtocol>: StandingsListBusinessLogic & StandingsListDataStore {
    
    let presenter: StandingsListPresentationLogic
    let standingsService: StandingsWorker<S>
    
    var nationalLeagueStandings: Standings.LeagueRecord?
    var americanLeagueStandings: Standings.LeagueRecord?
    
    let wildcardFormatter = WildcardFormatter()
    
    init(presenter: StandingsListPresentationLogic, standingsStore: S, nationalLeagueStandings: Standings.LeagueRecord? = nil, americanLeagueStandings: Standings.LeagueRecord? = nil) {
        self.presenter = presenter
        self.nationalLeagueStandings = nationalLeagueStandings
        self.americanLeagueStandings = americanLeagueStandings
        self.standingsService = StandingsWorker(store: standingsStore)
    }
    
    func loadStandings() async {
        
        do {
            let standings = try await standingsService.fetchStandings(for: Date())
            
            nationalLeagueStandings = standings.nationalLeagueRecords
            americanLeagueStandings = standings.americanLeagueRecords
            
            let output = StandingsList.LoadStandings.Output(nationalLeagueStandings: standings.nationalLeagueRecords,
                                                            americanLeagueStandings: standings.americanLeagueRecords)
            
            presenter.presentStandingsList(output: output)
        } catch {
            let sceneError = SceneError(errorDescription: error.localizedDescription)
            presenter.presentSceneError(sceneError)
        }
    }
    
    func loadWildcardStandings() {
        guard let nationalLeagueStandings = nationalLeagueStandings, let americanLeagueStandings = americanLeagueStandings else {
            let sceneError = SceneError(errorDescription: "Did find nil standings data.")
            presenter.presentSceneError(sceneError)
            
            return
        }
        
        let nlWildcard = wildcardFormatter.formatWildcardStandings(forLeague: nationalLeagueStandings)
        let alWildcard = wildcardFormatter.formatWildcardStandings(forLeague: americanLeagueStandings)
        
        let output = StandingsList.FormatWildcard.Output(nationalLeagueWildcard: nlWildcard,
                                                   americanLeagueWildcard: alWildcard)
        
        presenter.presentWildcardStandingsList(output: output)
    }
    
    func loadStanding(forTeam teamID: Int) {
        for league in [americanLeagueStandings, nationalLeagueStandings] {
            guard let records = league?.allRecords else {
                continue
            }
            for teamRecord in records {
                if teamRecord.teamID == teamID {
                    presenter.presentTeamStandingDetail(ouput: .init(standing: teamRecord))
                    break
                }
            }
        }
    }

}
