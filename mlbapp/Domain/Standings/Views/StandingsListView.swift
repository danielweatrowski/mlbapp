//
//  StandingsListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI


struct StandingsListView: View {
    
    @StateObject var viewModel: StandingsListViewModel
    
    @State private var selectedLeague: Int = 0
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loaded:
                    if selectedLeague == 0, let listViewModel = viewModel.nationalListViewModel {
                        standingsList(listViewModel)
                    } else if selectedLeague == 1, let listViewModel = viewModel.americanListViewModel {
                        standingsList(listViewModel)
                    } else if selectedLeague == 2, let listViewModel = viewModel.wildcardListViewModel {
                        standingsList(listViewModel)
                    }
                case .loading:
                    ProgressView()
                default: EmptyView()
                }
            }
            VStack(spacing: 0) {
                Spacer()
                
                ToolbarPickerView(title: "League", item0Title: ActiveLeague.national.nameShort, item1Title: ActiveLeague.american.nameShort, item2Title: "Wildcard", selection: $selectedLeague)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .withSceneError($viewModel.sceneError)
        .task {
            await viewModel.interactor?.loadStandings()
        }
        .onChange(of: selectedLeague) { selection in
            guard selection == 2 else { return }
            viewModel.interactor?.loadWildcardStandings()
        }
    }
    
    @ViewBuilder
    func standingsList(_ listViewModel: StandingsList.ListViewModel) -> some View {
        
        List {
            ForEach(listViewModel.sections, id: \.id) { section in
                Section(section.title) {
                    Grid {
                        StandingsHeaderRowView()
                        Divider()
                        
                        ForEach(section.rows, id: \.self) { rowViewModel in
                            StandingsRowView(viewModel: rowViewModel)

                            if rowViewModel != section.rows.last {
                                Divider()
                                    .edgesIgnoringSafeArea(.horizontal)
                                    .if(rowViewModel.teamRank == 3 && selectedLeague == 2) { view in
                                        view
                                            .frame(height: 2)
                                            .overlay(.primary)
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding(.bottom, 46)
    }
}

extension StandingsListView {
    static func configure<S: StandingsStoreProtocol>(with store: S) -> Self {
        let viewModel = StandingsListViewModel()
        let presenter = StandingsListPresenter(viewModel: viewModel)
        
        let interactor = StandingsListInteractor(presenter: presenter,
                                                 standingsStore: store)
        
        viewModel.interactor = interactor
        return StandingsListView(viewModel: viewModel)
    }
}
