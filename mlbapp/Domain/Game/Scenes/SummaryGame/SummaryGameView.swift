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
        List {
            ForEach(viewModel.sections, id: \.id) { section in
                Section(header: Text(section.inningName)) {
                    ForEach(section.plays, id: \.id) { play in
                        Text(play.description)
                    }
                }
            }
        }
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

//struct SummaryGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        SummaryGameView()
//    }
//}
