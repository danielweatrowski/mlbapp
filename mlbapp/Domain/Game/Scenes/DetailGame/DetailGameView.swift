//
//  DetailGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct DetailGameView: View {
        
    @StateObject var interactor: DetailGameInteractor
    @EnvironmentObject var router: Router
    @StateObject var viewModel: DetailGame.ViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded:
                list
            case .error:
                EmptyView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor.loadGame()
        }
    }
    
    @ViewBuilder
    var list: some View {
        List {
            Section {
                DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
                    .listRowInsets(EdgeInsets())
                
                if viewModel.isGameLiveOrFinal {
                    LinescoreGridView(viewModel: $viewModel.lineScoreViewModel,
                                      embedInScrollView: true)
                        .listRowInsets(EdgeInsets())
                        .padding()
                    NavigationLink("Summary", value: RouterDestination.summaryGame(gameID: viewModel.gameID,
                                                                                   homeTeamName: viewModel.homeTeamAbbreviation,
                                                                                   awayTeamName: viewModel.awayTeamAbbreviation))
                    NavigationLink("Boxscore", value: RouterDestination.boxscore(gameID: viewModel.gameID,
                                                                                 formattedGameDate: viewModel.gameDate,
                                                                                 homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                                                 awayTeamAbbreviation: viewModel.awayTeamAbbreviation,
                                                                                 players: interactor.playerHash ?? [:]))
                }
            }
            
//            Section("AT BAT") {
//                if let currentPlayVM = viewModel.currentPlayViewModel {
//                    CurrentPlayView(viewModel: currentPlayVM)
//                        .listRowInsets(EdgeInsets())
//                    DetailGamePitcherView(titleText: "On Deck", pitcherNameText: "Ive, J", pitcherInfoText: "0-2, .000 AVG")
//                }
//            }
            
            if viewModel.showProbablePitchers {
                Section("Probable Pitchers") {
                    ProbablePitchersView(viewModel: viewModel.probablePitchersViewModel)
                }
            }
            
            if viewModel.showDecisions {
                Section("Decisions") {
                    DecisionsInfoView(viewModel: $viewModel.decisionsViewModel)
                        .listRowInsets(EdgeInsets())
                }
            }
            
            Section("Team Info") {
                NavigationLink("Starting Lineups", value: RouterDestination.lineupDetail(gameID: viewModel.gameID,
                                                                                         boxscore: interactor.boxscore))
                NavigationLink("Rosters", value: RouterDestination.rosterDetail(homeTeam: interactor.homeTeam,
                                                                                awayTeam: interactor.awayTeam,
                                                                                gameDate: interactor.gameDate))
            }
            
            Section("Game Info") {
                ForEach(viewModel.infoItems, id: \.self) { item in
                    HStack {
                        Text(item.type.title)
                        Spacer()
                        Text(item.value)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
    
}

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailGameConfigurator.configure(for: Seeds.Games.PHI_NYM_20190424.id)
        
    }
}


