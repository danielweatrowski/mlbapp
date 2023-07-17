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
    let dataProvider: DataProvider = DataProvider()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ScoresTab(dataProvider: dataProvider)
                .tabItem {
                    Label("Scores", systemImage: "squareshape.split.2x2")
                }
                .environmentObject(MLBLogoService())
                .environmentObject(router)
                
                StandingsTab(dataProvider: dataProvider)
                    .tabItem {
                        Label("Standings", systemImage: "flag.2.crossed")
                    }
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