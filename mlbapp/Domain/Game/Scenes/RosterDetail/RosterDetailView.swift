//
//  RosterDetailView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI

struct RosterDetailView: View {
    
    @StateObject var viewModel: RosterDetail.ViewModel
    let interactor: RosterDetailBusinessLogic?
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                    EmptyView()
            case .loading:
                ProgressView()
            default: EmptyView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Teams", selection: $viewModel.teamSelection) {
                    Text("Home").tag(0)
                    Text("Away").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        }
        .withSceneError($viewModel.sceneError)
        .onAppear {
            interactor?.loadRoster()
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}

extension RosterDetailView {
    static func configure(gameID: Int) -> RosterDetailView {
        let viewModel = RosterDetail.ViewModel()
        let presenter = RosterDetailPresenter(viewModel: viewModel)
        let interactor = RosterDetailInteractor(gameID: gameID, presenter: presenter)
        
        return RosterDetailView(viewModel: viewModel, interactor: interactor)
    }
}
