//
//  LineupDetailView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/19/23.
//

import SwiftUI

struct LineupDetailView: View {
    
    @StateObject var viewModel: LineupDetail.ViewModel
    let interactor: LineupDetailBusinessLogic?
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                List {
                    Section("Home") {
                        homeLineup
                    }
                    
                    Section("Away") {
                        awayLineup
                    }
                }
            case .loading:
                ProgressView()
            default: EmptyView()
            }
        }
        .onAppear {
            interactor?.getLineups()
        }
        .navigationTitle(viewModel.navigationTitle)
    }
    
    @ViewBuilder
    var homeLineup: some View {
        if viewModel.homeLineup.isEmpty {
            Text("No Data Found.")
                .italic()
                .foregroundColor(.secondary)
        } else {
            ForEach(viewModel.homeLineup, id: \.id) { rowVM in
                LineupRowView(viewModel: rowVM)
            }
        }
    }
    
    @ViewBuilder
    var awayLineup: some View {
        if viewModel.awayLineup.isEmpty {
            Text("No Data Found.")
                .italic()
                .foregroundColor(.secondary)
        } else {
            ForEach(viewModel.awayLineup, id: \.id) { rowVM in
                LineupRowView(viewModel: rowVM)
            }
        }
    }
}

extension LineupDetailView {
    static func configure(gameID: Int, boxscore: Boxscore?) -> LineupDetailView {
        let viewModel = LineupDetail.ViewModel()
        let presenter = LineupDetailPresenter(viewModel: viewModel)
        let interactor = LineupDetailInteractor(gameID: gameID, boxscore: boxscore, presenter: presenter)
        
        return LineupDetailView(viewModel: viewModel, interactor: interactor)
    }
}
