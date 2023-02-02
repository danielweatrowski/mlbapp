//
//  DetailGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct DetailGameView: View {
        
    var interactor: DetailGameInteractor
    @ObservedObject var viewModel: DetailGame.ViewModel
    
    var body: some View {
        ScrollView {
            
            DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
                .padding(.horizontal)
            
            DetailGameInfoView(viewModel: $viewModel.infoViewModel)
            
            VStack() {
                LineScoreView(viewModel: $viewModel.lineScoreViewModel)
                    .padding()
                    .background()
                    .cornerRadius(16)
                
                BoxscoreView(viewModel: $viewModel.boxscoreViewModel)
                    .padding()
                    .background()
                    .cornerRadius(16)
                
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle($viewModel.navigationTitle)
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            interactor.getViewModel()
        }
    }
}

//struct DetailGameView_Previews: PreviewProvider {
//    static let game1 = Game.test_0
//    static var previews: some View {
//
//        let interactor = DetailGameInteractor(game: game1)
//        DetailGameView(interactor: interactor, viewModel: )
//    }
//}


