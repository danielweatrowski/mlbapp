//
//  DetailGameConfigurator.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/27/23.
//

import Foundation

struct DetailGameConfigurator {
    
    static func configure(for gameID: Int) -> DetailGameView {
        let viewModel = DetailGame.ViewModel(gameID: gameID)
        let presenter = DetailGamePresenter(viewModel: viewModel)
        let interactor = DetailGameInteractor(presenter: presenter, gameID: gameID)
        let view = DetailGameView(interactor: interactor, viewModel: viewModel)
        
        return view
    }
}
