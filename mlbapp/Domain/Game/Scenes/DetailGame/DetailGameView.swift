//
//  DetailGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct DetailGameView: View {
        
    var interactor: DetailGameInteractor
    @ObservedObject var viewModel: DetailGame.ViewModel
    @State private var teamBoxSelection = 0
    
    private var selectedTeamAbbreviation: String {
        return teamBoxSelection == 0
        ? viewModel.homeTeamAbbreviation
        : viewModel.awayTeamAbbreviation
    }
    
    var body: some View {
        ScrollView {
            VStack() {

                DetailGameHeaderView(viewModel: $viewModel.headerViewModel)
            }
            .padding([.leading, .trailing])
            
            VStack {
                
                ListSection(title: nil) {
                    DecisionsInfoView(viewModel: $viewModel.decisionsViewModel)
                }
                .padding(.top, -8)
                
                ListSection(title: "Line") {
                    LinescoreGridView(viewModel: $viewModel.lineScoreViewModel)
                }
            
                ListSection(title: "Batters") {
                    BoxscoreGridView(viewModel: $viewModel.boxscoreViewModel, teamBoxSelection: $teamBoxSelection)
                }
                
                battingDetailsSection
                runningDetailsSection
                fieldingDetailsSection
                
                ListSection(title: "Pitchers") {
                    BoxscoreGridView(viewModel: $viewModel.pitchingBoxscoreViewModel, teamBoxSelection: $teamBoxSelection)
                }

                /*
                VStack {
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                        Text("Stadium")
                            .font(.subheadline)
                        Spacer()
                        
                    }
                    Divider()
                    HStack {
                        Image(systemName: "calendar.circle.fill")
                        Text("Date")
                            .font(.subheadline)
                        Spacer()
                        
                    }
                }
                .padding()
                .background()
                .cornerRadius(16) */
                
            }
            .padding([.leading, .trailing])
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
        .background(Color(uiColor: .systemGroupedBackground))
        .onAppear {
            interactor.loadGame()
        }
    }
    
    @ViewBuilder
    var battingDetailsSection: some View {
        let teamDetails = teamBoxSelection == 0
        ? viewModel.homeTeamBattingDetails
        : viewModel.awayTeamBattingDetails
        
        if let details = teamDetails, !details.isEmpty {
            ListSection(title: "Batting") {
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
            ListSection(title: "Fielding") {
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
            ListSection(title: "Base Running") {
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

struct DetailGameView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailGameConfigurator.configure(for: Seeds.Games.PHI_NYM_20190424.id)
        
    }
}


