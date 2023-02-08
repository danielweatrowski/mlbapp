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
    @State private var teamBoxSelection = 0
    
    var body: some View {
        ScrollView {
            
            Text(viewModel.gameDate)
                .frame(maxWidth: .infinity, alignment: .leading)
                .bold()
                .font(.subheadline)
                .padding(.leading)
                .padding(.top, -4)
            
            VStack() {

                DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
                    .padding()
                    .padding(.vertical)
                    .background()
                    .cornerRadius(16)
                
            }
            .padding([.leading, .trailing])
            
            VStack() {
                LineScoreView(viewModel: $viewModel.lineScoreViewModel)
                    .padding()
                    .background()
                    .cornerRadius(16)
                
                BoxscoreView(viewModel: $viewModel.boxscoreViewModel)
                    .padding()
                    .background()
                    .cornerRadius(16)
                
                VStack {
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                        Text("Stadium")
                            .font(.subheadline)
                        Spacer()
                        
                        Text(viewModel.infoViewModel?.venueName ?? "")
                            .font(.subheadline)
                    }
                    Divider()
                    HStack {
                        Image(systemName: "calendar.circle.fill")
                        Text("Date")
                            .font(.subheadline)
                        Spacer()
                        
                        Text(viewModel.infoViewModel?.gameDate ?? "")
                            .font(.subheadline)
                    }
                }
                .padding()
                .background()
                .cornerRadius(16)
                
            }
            .padding([.leading, .trailing])
        }

        .navigationTitle(viewModel.navigationTitle)
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


