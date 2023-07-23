//
//  StandingsListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation

protocol StandingsListPresentationLogic: SceneErrorPresentable {
    func presentStandingsList(output: StandingsList.LoadStandings.Output)
    func presentWildcardStandingsList(output: StandingsList.FormatWildcard.Output)
}

struct StandingsListPresenter<V: StandingsListRenderingLogic>: StandingsListPresentationLogic {

    let viewModel: V
    
    func presentStandingsList(output: StandingsList.LoadStandings.Output) {
        
        var lists: [StandingsList.ListViewModel] = []
        for league in [output.nationalLeagueStandings, output.americanLeagueStandings] {
            
            
            
            let listViewModel = StandingsList.ListViewModel(sections: [
                .init(title: league.west.division.nameShort, rows: formatDivision(league.west)),
                .init(title: league.central.division.nameShort, rows: formatDivision(league.central)),
                .init(title: league.east.division.nameShort, rows: formatDivision(league.east))
            ])
            
            lists.append(listViewModel)
        }
        
        let output = StandingsList.LoadStandings.ViewModel(nationalStandingsList: lists[0],
                                                           americanStandingsList: lists[1])
        viewModel.renderStandingsList(viewModel: output)
    }
    
    func presentWildcardStandingsList(output: StandingsList.FormatWildcard.Output) {
        var wildcardSections = [StandingsList.ListViewModel.SectionItem]()
        
        for wildcard in [output.nationalLeagueWildcard, output.americanLeagueWildcard] {
            
            let leadersSection = StandingsList.ListViewModel.SectionItem(title: "Leaders",
                                                                         rows: formatSectionRows(wildcard.teamLeaders))
            let contendersSection = StandingsList.ListViewModel.SectionItem(title: "Wildcard",
                                                                            rows: formatSectionRows(wildcard.wildcardTeamStandings))
            
            wildcardSections.append(leadersSection)
            wildcardSections.append(contendersSection)

        }
        
        let wildcardList = StandingsList.ListViewModel(sections: wildcardSections)
        let output = StandingsList.FormatWildcard.ViewModel(wildcardStandingsList: wildcardList)
        viewModel.renderWildcardStandingsList(viewModel: output)
    }

    
    func presentSceneError(_ sceneError: SceneError) {
        viewModel.renderSceneError(sceneError)
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
