//
//  DetailGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

protocol DetailGameDisplayLogic {
    func displayGame(viewModel: DetailGame.DetailGame.ViewModel)
}


struct DetailGameView<I>: View where I: DetailGameBusinessLogic & DetailGameDataStore {
    
    //@ObservedObject var dataStore: DetailGameViewDataStore
    @ObservedObject var interactor: I
    
    var body: some View {
        ScrollView {
            
            DetailGameHeaderView(viewModel: $interactor.headerViewModel)
            
            DetailGameInfoView(viewModel: $interactor.infoViewModel)

            VStack() {
                LineScoreView()
                    .padding()
                    .background()
                    .cornerRadius(16)
                
//                HStack() {
//                    Text("Win:")
//                        .bold()
//                    Text("John Doe (0-0)")
//                        .font(.subheadline)
//
//                    Spacer()
//                }
//                .padding(.leading)
//
//                HStack() {
//                    Text("Loss:")
//                        .bold()
//                    Text("John Doe (0-0)")
//                        .font(.subheadline)
//
//                    Spacer()
//                }
//                .padding(.leading)
            }
            .padding([.leading, .trailing])
            
            
            
        }
        .navigationTitle(interactor.title)
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            interactor.getViewModel()
        }

    }
}

extension DetailGameView: DetailGameDisplayLogic {
    func displayGame(viewModel: DetailGame.DetailGame.ViewModel) {
        interactor.headerViewModel = viewModel.headerViewModel
        interactor.infoViewModel = viewModel.infoViewModel
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game1 = LookupGame.LookupGameResult(id: 1,
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
        
        let interactor = DetailGameInteractor()
        DetailGameView(interactor: interactor)
    }
}


