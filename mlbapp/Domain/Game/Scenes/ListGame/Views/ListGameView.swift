//
//  ListGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import SwiftUI

struct ListGameView: View {
    
    var viewModel: ListGame.ListGameLookupResults.ViewModel
    
    var interactor: ListGameBusinessLogic?
    //var router: ListGameRoutingLogic?
    
    var columns = [
        GridItem()
    ]
    
    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(viewModel.games, id: \.id) { game in
//                    let viewModel = ListGame.GameLookupItem.ViewModel(game: game)
//                    ListGameRow(viewModel: viewModel)
//                }
//            }
//            .background {
//                 RoundedRectangle(cornerRadius: 12.0)
//                     .fill(Color(.white))
//                     .padding()
//            }
//        }
//        .background(.quaternary)
        List(viewModel.games) { game in
            let viewModel = ListGame.GameLookupItem.ViewModel(game: game)
            ListGameRow(viewModel: viewModel)
        }
        .navigationTitle("Lookup Results")
    }
}

struct ListGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = LookupGame.LookupGameResult(id: 1,
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
                                               venueName: "Dodgers Stadium")
        
        let viewModel = ListGame.ListGameLookupResults.ViewModel(games: [game])
        ListGameView(viewModel: viewModel)
    }
}
