//
//  StandingsListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation


protocol StandingsListBusinessLogic {
    func loadStandings() async
    func loadWildcardStandings()
}

protocol StandingsListDataStore {
    var nationalLeagueStandings: Standings.LeagueRecord? { get }
    var americanLeagueStandings: Standings.LeagueRecord? { get }
}

class StandingsListInteractor: StandingsListBusinessLogic & StandingsListDataStore {
    
    let presenter: StandingsListPresentationLogic
    let standingsWorker = StandingsWorker(store: MLBAPIRepository())
    
    var nationalLeagueStandings: Standings.LeagueRecord?
    var americanLeagueStandings: Standings.LeagueRecord?
    
    init(presenter: StandingsListPresentationLogic, nationalLeagueStandings: Standings.LeagueRecord? = nil, americanLeagueStandings: Standings.LeagueRecord? = nil) {
        self.presenter = presenter
        self.nationalLeagueStandings = nationalLeagueStandings
        self.americanLeagueStandings = americanLeagueStandings
    }
    
    func loadStandings() async {
        
        do {
            let standings = try await standingsWorker.fetchStandings(for: Date())
            
            let output = StandingsList.Output(nationalLeagueStandings: standings.nationalLeagueRecords,
                                              americanLeagueStandings: standings.americanLeagueRecords)
            
            nationalLeagueStandings = standings.nationalLeagueRecords
            americanLeagueStandings = standings.americanLeagueRecords
            
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
        
        // TODO: Format standings into wildcard standings
        // TODO: Use SET!! To more easily filter?
        let nationalLeagueLeaders = nationalLeagueStandings.allRecords.filter({Int($0.rank) == 1})
        let americanLeagueLeaders = americanLeagueStandings.allRecords.filter({Int($0.rank) == 1})
        
        var nationalLeagueContenders = nationalLeagueStandings.allRecords.subtracting(nationalLeagueLeaders)
        var americanLeagueContenders = americanLeagueStandings.allRecords.subtracting(americanLeagueLeaders)
        
        let nlContendersSorted = nationalLeagueContenders.sorted {
            return $0.wildCardRank < $1.wildCardRank
        }
        
        let alContendersSorted = americanLeagueContenders.sorted {
            return $0.wildCardRank < $1.wildCardRank
        }
        
        print(nlContendersSorted.map({$0.teamAbbreviation}))
                
        let nationalWildcard = Standings.Wildcard.LeagueStanding(league: .national,
                                                                teamLeaders: Array(nationalLeagueLeaders),
                                                                wildcardTeamStandings: nlContendersSorted)
        
        let americanWildcard = Standings.Wildcard.LeagueStanding(league: .american,
                                                                 teamLeaders: Array(americanLeagueLeaders),
                                                                 wildcardTeamStandings: alContendersSorted)
        
        let output = StandingsList.Wildcard.Output(nationalLeagueWildcard: nationalWildcard,
                                                   americanLeagueWildcard: americanWildcard)
        
        presenter.presentWildcardStandingsList(output: output)

    }
}
