//
//  DetailGameConfigurator.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/27/23.
//

import Foundation

struct DetailGameConfigurator {
    static func configure(for game: Game) -> DetailGameView {
        let viewModel = DetailGame.ViewModel(navigationTitle: game.abbreviation, gameDate: game.date.formatted())
        let presenter = DetailGamePresenter(viewModel: viewModel)
        let interactor = DetailGameInteractor(presenter: presenter, game: game)
        let view = DetailGameView(interactor: interactor, viewModel: viewModel)
        
        return view
    }
}
