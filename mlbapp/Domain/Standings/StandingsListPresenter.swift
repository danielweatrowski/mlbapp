//
//  StandingsListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation

protocol StandingsListPresentationLogic: SceneErrorPresentable {
    func presentStandingsList(output: StandingsList.Output)
}

struct StandingsListPresenter: StandingsListPresentationLogic {

    let viewModel: StandingsList.ViewModel
    
    func presentStandingsList(output: StandingsList.Output) {
        
        // TODO: Use tuple for extra safety
        var lists: [StandingsList.ListViewModel] = []
        for league in [output.nationalLeagueStandings, output.americanLeagueStandings] {
            
            
            
            let listViewModel = StandingsList.ListViewModel(sections: [
                .init(title: league.west.division.nameShort, rows: formatDivision(league.west)),
                .init(title: league.central.division.nameShort, rows: formatDivision(league.central)),
                .init(title: league.east.division.nameShort, rows: formatDivision(league.east))
            ])
            
            lists.append(listViewModel)
        }
        
        DispatchQueue.main.async {
            viewModel.nationalListViewModel = lists[0]
            viewModel.americanListViewModel = lists[1]
            
            viewModel.state = .loaded
        }
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
    
    private func formatDivision(_ division: Standings.DivisionRecord) -> [StandingsRowViewModel] {
        return division.teamStandings.map { team in
            return formatTeam(team)
        }
    }
    
    private func formatTeam(_ team: Standings.TeamRecord) -> StandingsRowViewModel {
        return StandingsRowViewModel(teamAbbreviation: team.teamAbbreviation,
                                     wins: String(team.wins),
                                     losses: String(team.losses),
                                     winningPCT: team.winPercentage,
                                     gamesBehind: team.gamesBehind,
                                     lastTenRecord: "-",
                                     streak: team.streak)
    }

}
