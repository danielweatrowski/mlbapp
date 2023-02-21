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
                
                BoxscoreView(viewModel: $viewModel.boxscoreViewModel, teamBoxSelection: $teamBoxSelection)
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
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Picker("Teams", selection: $teamBoxSelection) {
                    Text(viewModel.homeTeamAbbreviation).tag(0)
                    Text(viewModel.awayTeamAbbreviation).tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            interactor.getViewModel()
        }
    }
}

struct DetailGameView_Previews: PreviewProvider {
    static let game1 = Game.test_0
    static var previews: some View {
        NavigationView {
            DetailGameConfigurator.configure(for: game1)
        }
    }
}


