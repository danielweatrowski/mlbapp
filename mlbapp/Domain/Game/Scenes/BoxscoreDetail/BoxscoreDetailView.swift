//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import SwiftUI

struct BoxscoreDetailView: View {
    
    let interactor: BoxscoreDetailBusinessLogic?
    
    @StateObject var viewModel: BoxscoreDetail.ViewModel
    
    @State
    private var teamBoxSelection = 0
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded:
                List {
                    Section {
                        BoxscoreGridView(viewModel: $viewModel.boxscoreViewModel, teamBoxSelection: $teamBoxSelection)
                    }
                    
                    battingDetailsSection
                    runningDetailsSection
                    fieldingDetailsSection
                    
                    Section {
                        BoxscoreGridView(viewModel: $viewModel.pitchingBoxscoreViewModel, teamBoxSelection: $teamBoxSelection)
                    }
                }
                .listStyle(.insetGrouped)
            case .error:
                EmptyView()
            }
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
        .onAppear {
            interactor?.loadBoxscore()
        }
    }
    
    @ViewBuilder
    var battingDetailsSection: some View {
        let teamDetails = teamBoxSelection == 0
        ? viewModel.homeTeamBattingDetails
        : viewModel.awayTeamBattingDetails
        
        if let details = teamDetails, !details.isEmpty {
            Section("Batters") {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(details, id: \.self) { detail in
                        Group {
                            Text(detail.title)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.detail)")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var fieldingDetailsSection: some View {
        let teamDetails = teamBoxSelection == 0
        ? viewModel.homeTeamFieldingDetails
        : viewModel.awayTeamFieldingDetails
        
        if let details = teamDetails, !details.isEmpty {
            Section("Fielding") {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(details, id: \.self) { detail in
                        Group {
                            Text(detail.title)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.detail)")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var runningDetailsSection: some View {
        let teamDetails = teamBoxSelection == 0
        ? viewModel.homeTeamRunningDetails
        : viewModel.awayTeamRunningDetails
        
        if let details = teamDetails, !details.isEmpty {
            Section("Base Running") {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(details, id: \.self) { detail in
                        Group {
                            Text(detail.title)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.detail)")
                                .font(.subheadline)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
        } else {
            EmptyView()
        }
    }
}

extension BoxscoreDetailView {
    static func configure(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, players: [Int: Player]) -> Self {
        let viewModel = BoxscoreDetail.ViewModel(gameID: gameID,
                                                 formattedGameDate: formattedGameDate,
                                                 homeTeamAbbreviation: homeTeamAbbreviation,
                                                 awayTeamAbbreviation: awayTeamAbbreviation)
        let presenter = BoxscoreDetailPresenter(viewModel: viewModel,  players: players)
        let interactor = BoxscoreDetailInteractor(presenter: presenter, gameID: gameID)
        
        return .init(interactor: interactor,
                     viewModel: viewModel)
    }
}

struct BoxscoreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreDetailView(interactor: nil,
                           viewModel: .init(gameID: 0,
                                            formattedGameDate: "03/31/2023 7:10 PM",
                                            homeTeamAbbreviation: "LAD",
                                            awayTeamAbbreviation: "SF"))
    }
}
