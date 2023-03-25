//
//  mlbappApp.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 10/19/22.
//

import SwiftUI

@main
struct mlbappApp: App {
    
    @StateObject var router = Router()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SearchGameView
                    .configure()
                    .withRouter()
            }
            .environmentObject(MLBLogoService())
            .environmentObject(router)

//            NavigationView {
//                DetailGameConfigurator.configure(for: 661849)
//                    .environmentObject(MLBLogoService())
//            }
        }

    }
}
