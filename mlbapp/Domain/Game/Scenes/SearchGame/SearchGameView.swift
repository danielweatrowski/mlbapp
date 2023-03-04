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
    @ObservedObject var router: SearchGameRouter
    
    @State private var selectedStartDate = Date()
    @State private var selectedEndDate = Date()
    
    //@State private var selectedHomeTeam: MLBTeam = MLBTeam.any
    @State private var selectedHomeTeamID: Int = .max

    //@State private var selectedAwayTeam: MLBTeam = MLBTeam.any
    @State private var selectedAwayTeamID: Int = ActiveTeam.any.id

    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false
    
    @State private var hideScores = false
    @State private var isRegularSeason = true
    
    // Navigation
    @State private var showingLookupGameResults: Bool = false
    
    var body: some View {
        NavigationView {

            Form {
                Section {
                    Picker(selection: $selectedHomeTeamID,
                           label: Text("Team")) {
                        ForEach(ActiveTeam.allTeams, id: \.id) {
                            Text($0.name)
                                .tag($0.id)
                        }
                    }
                    Picker(selection: $selectedAwayTeamID,
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
                    DatePicker(selection: $selectedStartDate,
                               displayedComponents: .date) {
                        Text("Start Date")
                    }

                    DatePicker(selection: $selectedEndDate,
                               displayedComponents: .date) {
                        Text("End Date")
                    }
                    
                    Toggle(isOn: $hideScores) {
                        Text("Hide Scores")
                    }
                    
                    Toggle(isOn: $isRegularSeason) {
                        Text("Regular Season Only")
                    }
                    
                } header: {
                    Text("Options")
                }
                Section {
                    HStack() {
                        Spacer()
                        Button("Search") {
                            createGameSearch()
                        }
                        .background(
                            // place navigation link in background of button so it's hidden from user
                            NavigationLink(destination: router.listGameDestination, isActive: $router.routingToListGame) { EmptyView() }
                        )
                        Spacer()
                    }

                }

            }
            .navigationTitle("Game Lookup")
            .alert(router.errorAlertTitle ?? "Something went wrong. Try again.", isPresented: $router.showingErrorAlert, actions: {})

        }
    }
    
    private func createGameSearch() {
        let request = SearchGame.Request(homeTeamID: selectedHomeTeamID,
                                         awayTeamID: selectedAwayTeamID,
                                         startDate: selectedStartDate,
                                         endDate: selectedEndDate)
        
        interactor?.createSearchGame(request: request)
    }
}

extension SearchGameView: SearchGameDisplayLogic {
    func displayLookupError(error: SearchGame.LookupGameError) {
        router.showErrorAlert(error: error)
    }
    
    func displayLookupResults(viewModel: ListGame.ViewModel) {
        router.routeToListGame(viewModel: viewModel)
    }
    
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let router = SearchGameRouter()
        SearchGameView(router: router)
    }
}
