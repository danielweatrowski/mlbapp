//
//  StandingsListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation

protocol StandingsListPresentationLogic: SceneErrorPresentable {
    func presentStandingsList(output: StandingsList.Output)
    func presentWildcardStandingsList(output: StandingsList.Wildcard.Output)
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
    
    func presentWildcardStandingsList(output: StandingsList.Wildcard.Output) {
        var wildcardSections = [StandingsList.ListViewModel.SectionItem]()
        
        for wildcard in [output.nationalLeagueWildcard, output.americanLeagueWildcard] {
            
            let leadersSection = StandingsList.ListViewModel.SectionItem(title: "Leaders",
                                                                         rows: formatSectionRows(wildcard.teamLeaders))
            let contendersSection = StandingsList.ListViewModel.SectionItem(title: "Wildcard",
                                                                            rows: formatSectionRows(wildcard.wildcardTeamStandings))
            
            wildcardSections.append(leadersSection)
            wildcardSections.append(contendersSection)

        }
        
        DispatchQueue.main.async {
            viewModel.wildcardListViewModel = StandingsList.ListViewModel(sections: wildcardSections)
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
    
    private func formatSectionRows(_ teams: [Standings.TeamRecord]) -> [StandingsRowViewModel] {
        return teams.map { team in
            return formatTeam(team, isWildcard: true)
        }
    }
    
    private func formatTeam(_ team: Standings.TeamRecord, isWildcard: Bool = false) -> StandingsRowViewModel {
        return StandingsRowViewModel(teamRank: team.wildCardRank,
                                     teamAbbreviation: team.teamAbbreviation,
                                     wins: String(team.wins),
                                     losses: String(team.losses),
                                     winningPCT: team.winPercentage,
                                     gamesBehind: isWildcard ? team.wildCardGamesBack : team.gamesBehind,
                                     lastTenRecord: "-",
                                     streak: team.streak)
    }

}
