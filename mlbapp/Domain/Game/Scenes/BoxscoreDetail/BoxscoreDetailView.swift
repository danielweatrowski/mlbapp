//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import SwiftUI
import Common
import Models

struct BoxscoreDetailView: View {
    
    let interactor: BoxscoreDetailBusinessLogic?
    
    @StateObject var viewModel: BoxscoreDetail.ViewModel
    
    @State
    private var teamBoxSelection = 0
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded:
                    List {
                        Section {
                            BoxscoreGridView(viewModel: $viewModel.battingBoxscoreViewModel, teamBoxSelection: $teamBoxSelection)
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
            VStack(spacing: 0) {
                Spacer()
                toolbar
            }
        }
        .withSceneError($viewModel.sceneError)
        .navigationTitle(viewModel.navigationTitle)
        .task {
            await interactor?.loadBoxscore()
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        HStack(alignment: .center, spacing: 0) {
            Picker("Teams", selection: $teamBoxSelection) {
                Text(viewModel.homeTeamAbbreviation).tag(0)
                Text(viewModel.awayTeamAbbreviation).tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
        }
        .frame(height: 40)
        .padding(.vertical, 4)
        .background(.ultraThickMaterial)
    }
    
    @ViewBuilder
    var battingDetailsSection: some View {
        let teamDetails = teamBoxSelection == 0
        ? viewModel.homeTeamBattingDetails
        : viewModel.awayTeamBattingDetails
        
        if let details = teamDetails, !details.isEmpty {
            Section("Batting") {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(details, id: \.self) { detail in
                        Group {
                            Text(detail.label)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.value)")
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
                            Text(detail.label)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.value)")
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
                            Text(detail.label)
                                .bold()
                                .font(.subheadline)
                            + Text(" \(detail.value)")
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
    static func configure(gameID: Int, formattedGameDate: String, homeTeamAbbreviation: String, awayTeamAbbreviation: String, boxscore: Boxscore_V2?, players: [Int: Player]) -> Self {
        let viewModel = BoxscoreDetail.ViewModel(gameID: gameID,
                                                 formattedGameDate: formattedGameDate,
                                                 homeTeamAbbreviation: homeTeamAbbreviation,
                                                 awayTeamAbbreviation: awayTeamAbbreviation)
        let presenter = BoxscoreDetailPresenter(viewModel: viewModel,  players: players)
        let interactor = BoxscoreDetailInteractor(presenter: presenter, gameID: gameID, boxscore: boxscore)
        
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
