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
        List {
            Section("Home") {
                ForEach(viewModel.homeLineup, id: \.self) { batter in
                    Text(batter)
                }
            }
            
            Section("Away") {
                ForEach(viewModel.awayLineup, id: \.self) { batter in
                    Text(batter)
                }
            }
        }
        .onAppear {
            interactor?.getLineups()
        }
        .navigationTitle(viewModel.navigationTitle)
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
