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
    
    private var selectedTeamAbbreviation: String {
        return teamBoxSelection == 0
        ? viewModel.homeTeamAbbreviation
        : viewModel.awayTeamAbbreviation
    }
    
    var body: some View {
        List {
            Section {
                DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
                    .listRowInsets(EdgeInsets())
                LinescoreGridView(viewModel: $viewModel.lineScoreViewModel)
                    .listRowInsets(EdgeInsets())
                    .padding()
            }
            Section("Decisions") {
                DecisionsInfoView(viewModel: $viewModel.decisionsViewModel)
                    .listRowInsets(EdgeInsets())
            }
            
            Section("Game Details") {
                NavigationLink("Summary", value: RouterDestination.empty)
                NavigationLink("Boxscore", value: RouterDestination.boxscore(gameID: viewModel.gameID,
                                                                             formattedGameDate: viewModel.gameDate,
                                                                             homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                                             awayTeamAbbreviation: viewModel.awayTeamAbbreviation))
                NavigationLink("Lineups", value: RouterDestination.empty)
                NavigationLink("Roster", value: RouterDestination.empty)
            }
            
            Section("Game Info") {
                // TODO
            }
        }
        .listStyle(.insetGrouped)
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
            interactor.loadGame()
        }
    }
    
    
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailGameConfigurator.configure(for: Seeds.Games.PHI_NYM_20190424.id)
        
    }
}


