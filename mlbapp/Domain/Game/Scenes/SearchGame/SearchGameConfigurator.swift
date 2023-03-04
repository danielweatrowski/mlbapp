//
//  SearchGameConfigurator.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/26/22.
//

import SwiftUI

extension SearchGameView {
    // TODO: Remove
    func configureView() -> some View {
        var view = self
        let interactor = SearchGameInteractor()
        let presenter = SearchGamePresenter()
        let router = SearchGameRouter()
        router.dataStore = interactor
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view

        return view
    }
}
