//
//  GameSearchView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/24/22.
//

import SwiftUI
protocol SearchGameDisplayLogic {
    func displayLookupError(error: LookupGame.LookupGameError)
    func displayLookupResults(viewModel: LookupGame.LookupGame.ViewModel)
}
struct LookupGameView: View {
    var interactor: SearchGameBusinessLogic?
    @ObservedObject var router: LookupGameRouter
    
    @State private var selectedStartDate = Date()
    @State private var selectedEndDate = Date()
    
    //@State private var selectedHomeTeam: MLBTeam = MLBTeam.any
    @State private var selectedHomeTeamIndex: Int = .max

    //@State private var selectedAwayTeam: MLBTeam = MLBTeam.any
    @State private var selectedAwayTeamIndex: Int = MLBTeam.any.rawValue

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
                    Picker(selection: $selectedHomeTeamIndex,
                           label: Text("Team")) {
                        ForEach(MLBTeam.allTeams, id: \.id) {
                            Text($0.name)
                                .tag($0.rawValue)
                        }
                    }
                    Picker(selection: $selectedAwayTeamIndex,
                           label: Text("Opponent")) {
                        ForEach(MLBTeam.allCases, id: \.id) {
                            Text($0.name)
                                .tag($0.rawValue)
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
        
        let request = LookupGame.LookupGame.Request(homeTeamIndex: selectedHomeTeamIndex,
                                                    awayTeamIndex: selectedAwayTeamIndex,
                                                    startDate: selectedStartDate,
                                                    endDate: selectedEndDate,
                                                    onlyRegularSeason: isRegularSeason)
        
        interactor?.createSearchGame(request: request)
    }
}

extension LookupGameView: SearchGameDisplayLogic {
    func displayLookupError(error: LookupGame.LookupGameError) {
        router.showErrorAlert(error: error)
    }
    
    func displayLookupResults(viewModel: LookupGame.LookupGame.ViewModel) {
        let listViewModel = ListGame.ListGameLookupResults.ViewModel(games: viewModel.results)
        router.routeToListGame(viewModel: listViewModel)
    }
    
}

struct GameSearchView_Previews: PreviewProvider {
    static var previews: some View {
        let router = LookupGameRouter()
        LookupGameView(router: router)
    }
}
