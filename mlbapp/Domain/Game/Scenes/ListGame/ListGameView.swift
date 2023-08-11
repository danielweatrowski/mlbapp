//
//  ListGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import UIKit
import SwiftUI
import Models

struct ListGameView: View {
    
    @StateObject var viewModel: ListGame.ViewModel
    @EnvironmentObject var router: Router
    var interactor: ListGameBusinessLogic?
    
    var columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            gameList
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )
        .navigationTitle("Lookup Results")
        .onAppear {
            interactor?.loadGames()
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

extension ListGameView {
    static func configure(results: [GameSearch.Result]) -> Self {
        let viewModel = ListGame.ViewModel()
        let presenter = ListGamePresenter(viewModel: viewModel)
        let interactor = ListGameInteractor(presenter: presenter, games: results)
        
        return ListGameView(viewModel: viewModel, interactor: interactor)
    }
}

struct ListGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        let viewModel = ListGame.ViewModel()
        ListGameView(viewModel: viewModel)
    }
}
