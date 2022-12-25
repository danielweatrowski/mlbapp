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
                LineScoreView(viewModel: $interactor.lineScoreViewModel)
                    .padding()
                    .background()
                    .cornerRadius(16)
                
                    // TODO: Pitching Line
                
                Button("Start", action: startGame)
                    .buttonStyle(.borderedProminent)
            }
            .padding([.leading, .trailing])
            
            
            
        }
        .navigationTitle(interactor.title)
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            interactor.getViewModel()
        }
    }
    
    func startGame() {
        interactor.startGame()
    }
}

extension DetailGameView: DetailGameDisplayLogic {
    
    @MainActor
    func displayGame(viewModel: DetailGame.DetailGame.ViewModel) {
        DispatchQueue.main.async {
            interactor.headerViewModel = viewModel.headerViewModel
            interactor.infoViewModel = viewModel.infoViewModel
            interactor.lineScoreViewModel = viewModel.lineScoreViewModel
        }
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static let game1 = MLBGame.test_0
    static var previews: some View {
        
        let interactor = DetailGameInteractor(game: game1)
        DetailGameView(interactor: interactor)
    }
}


