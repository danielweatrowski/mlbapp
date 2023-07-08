//
//  StandingsListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI


struct StandingsListView: View {
    
    @StateObject var viewModel: StandingsList.ViewModel
    let interactor: StandingsListBusinessLogic?
    
    @State private var selectedLeague: Int = 0
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                if selectedLeague == 0, let listViewModel = viewModel.nationalListViewModel {
                    standingsList(listViewModel)
                } else if selectedLeague == 1, let listViewModel = viewModel.americanListViewModel {
                    standingsList(listViewModel)
                }
            case .loading:
                ProgressView()
            default: EmptyView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack(alignment: .center) {
                    Picker(selection: $selectedLeague, label: Text("League")) {
                        Text(ActiveLeague.national.nameShort)
                            .tag(0)
                        Text(ActiveLeague.american.nameShort)
                            .tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .withSceneError($viewModel.sceneError)
        .task {
            await interactor?.loadStandings()
        }
    }
    
    @ViewBuilder
    func standingsList(_ listViewModel: StandingsList.ListViewModel) -> some View {
        
        List {
            ForEach(listViewModel.sections, id: \.title) { section in
                Section(section.title) {
                    Grid {
                        StandingsHeaderRowView()
                        Divider()
                        
                        ForEach(section.rows, id: \.self) { rowViewModel in
                            StandingsRowView(viewModel: rowViewModel)
                            
                            if rowViewModel != section.rows.last {
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension StandingsListView {
    static func configure() -> Self {
        let viewModel = StandingsList.ViewModel()
        let presenter = StandingsListPresenter(viewModel: viewModel)
        let interactor = StandingsListInteractor(presenter: presenter)
        return StandingsListView(viewModel: viewModel, interactor: interactor)
    }
}
