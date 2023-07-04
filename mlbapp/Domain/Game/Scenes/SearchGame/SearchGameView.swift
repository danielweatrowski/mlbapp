//
//  GameSearchView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/24/22.
//

import SwiftUI
protocol SearchGameDisplayLogic {
    func displayLookupError(error: SearchGame.LookupGameError)
    func displayLookupResults(viewModel: ListGame.ViewModel)
}

struct SearchGameView: View {
    var interactor: SearchGameBusinessLogic?
    @StateObject var viewModel: SearchGame.ViewModel
    @EnvironmentObject var router: Router
    // Navigation
    @State private var showingLookupGameResults: Bool = false
    
    var body: some View {

            Form {
                Section {
                    Picker(selection: $viewModel.selectedHomeTeamID,
                           label: Text("Team")) {
                        ForEach(ActiveTeam.allTeams, id: \.id) {
                            Text($0.name)
                                .tag($0.id)
                        }
                    }
                    Picker(selection: $viewModel.selectedAwayTeamID,
                           label: Text("Opponent")) {
                        ForEach(ActiveTeam.allCases, id: \.id) {
                            Text($0.name)
                                .tag($0.id)
                        }
                    }
                } header: {
                    Text("Teams")
                }
                
                Section {
                    DatePicker(selection: $viewModel.selectedStartDate,
                               displayedComponents: .date) {
                        Text("Start Date")
                    }

                    DatePicker(selection: $viewModel.selectedEndDate,
                               displayedComponents: .date) {
                        Text("End Date")
                    }
                    
                } header: {
                    Text("Options")
                }
                Section {
                    Button("Search") {
                        createGameSearch()
                    }
                }
                .navigationTitle("Game Lookup")
                .alert(viewModel.errorMessage ?? "Something went wrong. Try again.", isPresented: $viewModel.didError, actions: {})
        }
        .onReceive(viewModel.$searchResults) { results in
            guard let results = results, !results.isEmpty else {
                return
            }
            router.navigate(to: .gameList(results: results))
        }
        .onAppear {
            viewModel.searchResults = nil
        }
    }
    
    private func createGameSearch() {
        let request = SearchGame.Request(homeTeamID: viewModel.selectedHomeTeamID,
                                         awayTeamID: viewModel.selectedAwayTeamID,
                                         startDate: viewModel.selectedStartDate,
                                         endDate: viewModel.selectedEndDate)
        
        interactor?.createSearchGame(request: request)
    }
}

extension SearchGameView {
    static func configure() -> Self {
        let viewModel = SearchGame.ViewModel()
        let presenter = SearchGamePresenter(viewModel: viewModel)
        let interactor = SearchGameInteractor(presenter: presenter)
        
        return SearchGameView(interactor: interactor, viewModel: viewModel)
    }
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchGameView.configure()
    }
}
