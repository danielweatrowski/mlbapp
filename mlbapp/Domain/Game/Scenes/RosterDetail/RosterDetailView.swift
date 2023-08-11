//
//  RosterDetailView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI
import Models
import Common

struct RosterDetailView: View {
    
    @StateObject var viewModel: RosterDetail.ViewModel
    let interactor: (RosterDetailBusinessLogic & RosterDetailDataStore)?
        
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                List {
                    Section("Active") {
                        ForEach(viewModel.teamSelection == 0 ? viewModel.homeRoster : viewModel.awayRoster, id: \.id) { viewModel in
                            RosterRowView(viewModel: viewModel)
                        }
                    }
                }
            case .loading:
                ProgressView()
            default: EmptyView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Teams", selection: $viewModel.teamSelection) {
                    Text(interactor?.homeTeam?.teamName ?? "Home").tag(0)
                    Text(interactor?.awayTeam?.teamName ?? "Away").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        }
        .withSceneError($viewModel.sceneError)
        .onAppear {
            interactor?.loadRosters()
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

extension RosterDetailView {
    static func configure(homeTeam: Team?, awayTeam: Team?, gameDate: Date?) -> RosterDetailView {
        let viewModel = RosterDetail.ViewModel()
        let presenter = RosterDetailPresenter(viewModel: viewModel)
        let interactor = RosterDetailInteractor(homeTeam: homeTeam, awayTeam: awayTeam, gameDate: gameDate, presenter: presenter)
        
        return RosterDetailView(viewModel: viewModel, interactor: interactor)
    }
}
