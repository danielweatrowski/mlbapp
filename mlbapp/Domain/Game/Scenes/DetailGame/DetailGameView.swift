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
                    NavigationLink("Plays", value: RouterDestination.summaryGame(gameID: viewModel.gameID,
                                                                                   homeTeamName: viewModel.homeTeamAbbreviation,
                                                                                   awayTeamName: viewModel.awayTeamAbbreviation))
                    NavigationLink("Boxscore", value: RouterDestination.boxscore(gameID: viewModel.gameID,
                                                                                 formattedGameDate: viewModel.gameDate,
                                                                                 homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                                                 awayTeamAbbreviation: viewModel.awayTeamAbbreviation,
                                                                                 players: interactor.playerHash ?? [:]))
                    NavigationLink("Videos", value: RouterDestination.videosList(viewModel.gameID))
                }
            }
            
            if viewModel.gameStatus == .preview {
                ProbablePitchersSectionView(home: viewModel.probableHomeStarter,
                                            away: viewModel.probableAwayStarter)
            }
            
            if let winner = viewModel.winnerViewModel, let loser = viewModel.loserViewModel {
                
                GameDecisionsSectionView(winnerViewModel: winner,
                                         loserViewModel: loser,
                                         saverViewModel: viewModel.saverViewModel)
                
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


