//
//  StandingsDetailView.swift
//  
//
//  Created by Daniel Weatrowski on 8/13/23.
//

import SwiftUI
import Models

public struct StandingsDetailView: View {
    
    @StateObject var viewModel: StandingsDetailViewModel

    public var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                List {
                    ForEach(viewModel.sections, id: \.self) { section in
                        Section(section.title) {
                            ForEach(section.items, id: \.self) { item in
                                HStack {
                                    Text(item.item.title)
                                    Spacer()
                                    Text(item.value)
                                }
                            }
                        }
                    }
                }
            case .loading:
                ProgressView()
            default: EmptyView()
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            viewModel.interactor?.loadTeamStanding()
        }
    }
}

extension StandingsDetailView {
    public static func configure(standing: Standings.TeamRecord) -> Self {
        let viewModel = StandingsDetailViewModel(teamAbbreviation: standing.teamAbbreviation, season: standing.season)
        let presenter = StandingsDetailPresenter(viewModel: viewModel)
        let interactor = StandingsDetailInteractor(teamStanding: standing,
                                                   presenter: presenter)
        
        viewModel.interactor = interactor
        return StandingsDetailView(viewModel: viewModel)
    }
}
