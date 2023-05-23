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
            TabView {
                
                NavigationStack(path: $router.path) {
                    ScoresListView
                        .configure()
                }
                .tabItem {
                    Label("Scores", systemImage: "squareshape.split.2x2")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
                
                NavigationStack(path: $router.path) {
                    DetailGameConfigurator.configure(for: 661849)
                        .withRouter()
                }
                .tabItem {
                    Label("661849", systemImage: "list.dash")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
                
                NavigationStack(path: $router.path) {
                    SearchGameView
                        .configure()
                        .withRouter()
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
            }


//            NavigationView {
//                DetailGameConfigurator.configure(for: 661849)
//                    .environmentObject(MLBLogoService())
//            }
        }

    }
}
