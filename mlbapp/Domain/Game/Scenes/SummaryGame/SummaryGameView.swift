//
//  SummaryGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import SwiftUI

struct SummaryGameView: View {
    
    @StateObject var viewModel: SummaryGame.ViewModel
    let interactor: SummaryGameBusinessLogic?
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                List {
                    ForEach(viewModel.sections, id: \.id) { section in
                        Section(header: Text(section.inningName)) {
                            ForEach(section.plays, id: \.id) { playVM in
                                SummaryGamePlayView(viewModel: playVM)
                            }
                        }
                    }
                }
            case .loading:
                ProgressView()
            case .error:
                // TODO
                EmptyView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor?.loadGameSummary()
        }
    }
}

extension SummaryGameView {
    static func configure(gameID: Int) -> Self {
        let viewModel = SummaryGame.ViewModel(gameID: gameID)
        let presenter = SummaryGamePresenter(viewModel: viewModel)
        let interactor = SummaryGameInteractor(presenter: presenter, gameID: gameID)
        return SummaryGameView(viewModel: viewModel, interactor: interactor)
    }
}
