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
                        .withRouterSheets(sheetItem: $router.presentedSheet)
                        .withRouter()
                }
                .tabItem {
                    Label("Scores", systemImage: "squareshape.split.2x2")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
                
                NavigationStack(path: $router.path) {
                    StandingsListView
                        .configure()
                        .withRouter()
                }
                .tabItem {
                    Label("Standings", systemImage: "flag.2.crossed")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
            }
            .onAppear {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithDefaultBackground()
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
}
