//
//  SummaryGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import SwiftUI

struct SummaryGameView: View {
    
    @StateObject var viewModel: SummaryGame.ViewModel
    @StateObject var interactor: SummaryGameInteractor
    
    @State var teamSelection: Int = 0
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loaded:
                    List {
                        ForEach(viewModel.sections, id: \.id) { section in
                            Section(header: Text(section.inningName)) {
                                ForEach(section.plays, id: \.id) { playVM in
                                    SummaryGamePlayView(viewModel: playVM)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 46)
                case .loading:
                    ProgressView()
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
            await interactor.loadAllPlays()
        }
        .onChange(of: viewModel.filterType) { filterType in
            viewModel.state = .loading
            interactor.filterPlays(by: filterType)
        }
        .onChange(of: teamSelection) { selection in
            if let type = SummaryGame.TeamSelectionType(rawValue: selection) {
                interactor.filterPlays(by: type)
            }
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        HStack(alignment: .center, spacing: 0) {
            Picker("Play Picker", selection: $teamSelection) {
                Text("All").tag(0)
                Text(viewModel.homeTeamName).tag(1)
                Text(viewModel.awayTeamName).tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Menu {
                Picker(selection: $viewModel.filterType, label: Text("Filter Plays")) {
                    ForEach(SummaryGame.FilterType.allCases) { option in
                         Text(String(describing: option))
                     }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.trailing)
        }
        .frame(height: 40)

        .padding(.vertical, 4)
        .background(.ultraThickMaterial)
        
    }
}

extension SummaryGameView {
    static func configure(gameID: Int, homeTeamName: String, awayTeamName: String) -> Self {
        let viewModel = SummaryGame.ViewModel(gameID: gameID, homeTeamName: homeTeamName, awayTeamName: awayTeamName)
        let presenter = SummaryGamePresenter(viewModel: viewModel)
        let interactor = SummaryGameInteractor(presenter: presenter, gameID: gameID)
        return SummaryGameView(viewModel: viewModel, interactor: interactor)
    }
}
