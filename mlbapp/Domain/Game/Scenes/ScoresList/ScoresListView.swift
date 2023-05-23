//
//  ScoresListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import SwiftUI

struct ScoresListView: View {
    
    var interactor: ScoresListBusinessLogic?
    @StateObject private var viewModel: ScoresList.ViewModel
    
    var columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded:
                ScrollView {
                    gameList
                }
            case .error:
                EmptyView()
            }

        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor?.loadScores()
        }
    }
    
    @ViewBuilder
    var gameList: some View {
        if let rows = viewModel.rows {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(rows, id: \.id) { row in
                    
                    NavigationLink(value: RouterDestination.gameDetail(gameID: row.gameID)) {
                        ListGameRow(viewModel: row)
                            .background()
                            .cornerRadius(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding([
                    .bottom,
                    .leading,
                    .trailing
                ])
            }
        } else {
            EmptyView()
        }
    }
}

extension ScoresListView {
    static func configure() -> ScoresListView {
        let viewModel = ScoresList.ViewModel()
        let presenter = ScoresListPresenter(viewModel: viewModel)
        let interactor = ScoresListInteractor(presenter: presenter)
        
        return ScoresListView(interactor: interactor,
                              viewModel: viewModel)
    }
}
