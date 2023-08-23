//
//  DetailGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI
import Views
import Common

struct DetailGameView: View {
        
    @StateObject var interactor: DetailGameInteractor
    @EnvironmentObject var sceneProvider: SceneProvider
    @StateObject var viewModel: DetailGame.ViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let sections):
                list(for: sections)
            case .error:
                EmptyView()
            }
        }
        .withSceneError($viewModel.sceneError)
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor.loadGame()
        }
    }
    
    @ViewBuilder
    func list(for sections: [DetailGame.Section]) -> some View {
        List {
            ForEach(sections, id: \.self) { section in
                switch section {
                case .previewHeader:
                    Section {
                        if let viewModel = viewModel.previewHeaderViewModel {
                            PreviewHeaderView(viewModel: viewModel)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                case .header:
                Section {
                    if viewModel.isGameLiveOrFinal {
                        DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
                            .listRowInsets(EdgeInsets())
                        
                        LinescoreGridView(viewModel: viewModel.lineScoreViewModel,
                                          embedInScrollView: true)
                        .listRowInsets(EdgeInsets())
                        .padding()
                    }
                }
                case .probablePitchers:
                    ProbablePitchersSectionView(home: viewModel.probableHomeStarter,
                                                away: viewModel.probableAwayStarter)
                case .decisions:
                    if let winner = viewModel.winnerViewModel, let loser = viewModel.loserViewModel {
                        
                        GameDecisionsSectionView(winnerViewModel: winner,
                                                 loserViewModel: loser,
                                                 saverViewModel: viewModel.saverViewModel)
                        
                    }
                case .gameInfo:
                    Section("Game Info") {
                        NavigationLink("Plays", value: AppScene.summaryGame(gameID: viewModel.gameID,
                                                                                       homeTeamName: viewModel.homeTeamAbbreviation,
                                                                                       awayTeamName: viewModel.awayTeamAbbreviation))
                        NavigationLink("Boxscore", value: AppScene.boxscore(gameID: viewModel.gameID,
                                                                                     formattedGameDate: viewModel.gameDate,
                                                                                     homeTeamAbbreviation: viewModel.homeTeamAbbreviation,
                                                                                     awayTeamAbbreviation: viewModel.awayTeamAbbreviation, boxscore: interactor.boxscore,
                                                                                     players: interactor.playerHash ?? [:]))
                        NavigationLink("Videos", value: AppScene.videosList(viewModel.gameID))
                    }
                case .teamInfo:
                    Section("Team Info") {
                        NavigationLink("Starting Lineups", value: AppScene.lineupDetail(gameID: viewModel.gameID,
                                                                                                 boxscore: interactor.boxscore))
                        NavigationLink("Rosters", value: AppScene.rosterDetail(homeTeam: interactor.homeTeam,
                                                                                        awayTeam: interactor.awayTeam,
                                                                                        gameDate: interactor.gameDate))
                    }
                case .about:
                    Section("About") {
                        ForEach(viewModel.infoItems, id: \.self) { item in
                            HStack {
                                Text(item.type.title)
                                Spacer()
                                Text(item.value)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}


