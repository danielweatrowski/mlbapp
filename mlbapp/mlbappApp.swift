//
//  mlbappApp.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import SwiftUI

@main
struct mlbappApp: App {
    var body: some Scene {
        WindowGroup {
//            let router = LookupGameRouter()
//
//            LookupGameView(router: router).configureView()
            let viewModel = DetailPlayerViewModel()
            let presenter = DetailPlayerPresenter(viewModel: viewModel)
            let interactor = DetailPlayerInteractor(personID: 571448, presenter: presenter)
            DetailPlayerView(viewModel: viewModel, interactor: interactor)
        }
    }
}
