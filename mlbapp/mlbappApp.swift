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
//            LookupGameView(router: router).configureView()
            NavigationView {
                routeToDetailGame(game: Seeds.Games.PHI_NYM_20190424)
            }
        }

    }
    
    func routeToDetailGame(game: Game) -> DetailGameView {
        
        let view = DetailGameConfigurator.configure(for: game)
        
        return view
    }
}
