//
//  StandingsListViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/23/23.
//

import SwiftUI
import Models
import Common
import Views

protocol StandingsListRenderingLogic {
    func renderStandingsList(viewModel: StandingsList.LoadStandings.ViewModel)
    func renderWildcardStandingsList(viewModel: StandingsList.FormatWildcard.ViewModel)
    func renderStandingsDetail(teamStanding: Standings.TeamRecord)
    func renderSceneError(_ sceneError: SceneError)
}

class StandingsListViewModel: ObservableObject, StandingsListRenderingLogic {
    
    enum State {
        case loading, loaded, error
    }
    
    let navigationTitle: String = "Standings"
    var interactor: (StandingsListBusinessLogic & StandingsListDataStore)?
    
    var americanListViewModel: StandingsList.ListViewModel?
    var nationalListViewModel: StandingsList.ListViewModel?
    var wildcardListViewModel: StandingsList.ListViewModel?
    
    // published
    @Published var state: State = .loading
    @Published var sceneError: SceneError = SceneError()
    @Published var standingDetail: Standings.TeamRecord?
    
    func renderStandingsList(viewModel: StandingsList.LoadStandings.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.nationalListViewModel = viewModel.nationalStandingsList
            self?.americanListViewModel = viewModel.americanStandingsList
            
            // trigger render
            self?.state = .loaded
        }
    }
    
    func renderWildcardStandingsList(viewModel: StandingsList.FormatWildcard.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            
            self?.wildcardListViewModel = viewModel.wildcardStandingsList
            
            // trigger render
            self?.state = .loaded
        }
    }
    
    func renderSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async { [weak self] in
            self?.sceneError.presentAlert(sceneError)
        }
    }
    
    func renderStandingsDetail(teamStanding: Standings.TeamRecord) {
        DispatchQueue.main.async { [weak self] in
            self?.standingDetail = teamStanding
        }
    }


}
