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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension StandingsDetailView {
    public static func configure(standing: Standings.TeamRecord) -> Self {
        let viewModel = StandingsDetailViewModel()
        let presenter = StandingsDetailPresenter(viewModel: viewModel)
        let interactor = StandingsDetailInteractor(teamStanding: standing,
                                                   presenter: presenter)
        
        return StandingsDetailView(viewModel: viewModel)
    }
}
