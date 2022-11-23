//
//  ListGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import UIKit
import SwiftUI

struct ListGameView: View {
    
    var viewModel: ListGame.ListGameLookupResults.ViewModel
    
    var interactor: ListGameBusinessLogic?
    @ObservedObject var router: ListGameRouter
    
    var columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.games, id: \.id) { game in
                    
                    NavigationLink(destination: router.routeToDetailGame(game: game)) {
                        let viewModel = ListGame.GameLookupItem.ViewModel(game: game)
                        ListGameRow(viewModel: viewModel)
                            .background()
                            .cornerRadius(20)
                    }                    
                }
                .padding([
                    .bottom,
                    .leading,
                    .trailing
                ])
            }
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )

        .navigationTitle("Lookup Results")
    }
}

struct ListGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game1 = MLBGame(id: 1,
                           link: "",
                           date: Date(),
                           homeTeam: .dodgers,
                           homeTeamWins: 111,
                           homeTeamLosses: 2,
                           homeTeamScore: 9,
                           awayTeam: .padres,
                           awayTeamScore: 2,
                           awayTeamWins: 4,
                           awayTeamLosses: 120,
                           venueName: "Dodgers Stadium",
                           gameType: "R")
        let game2 = MLBGame(id: 2,
                           link: "",
                           date: Date(),
                           homeTeam: .angels,
                           homeTeamWins: 80,
                           homeTeamLosses: 2,
                           homeTeamScore: 3,
                           awayTeam: .athletics,
                           awayTeamScore: 2,
                           awayTeamWins: 93,
                           awayTeamLosses: 120,
                           venueName: "Angel Stadium",
                           gameType: "R")
        
        let viewModel = ListGame.ListGameLookupResults.ViewModel(games: [game1, game2])
        ListGameView(viewModel: viewModel, router: ListGameRouter())
    }
}
