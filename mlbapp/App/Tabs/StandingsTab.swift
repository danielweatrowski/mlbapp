//
//  StandingsTab.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/12/23.
//

import SwiftUI
import Standings
import Common

struct StandingsTab: View {
    
    @StateObject var sceneProvider = SceneProvider()
    let dataProvider: DataProvider
    
    var body: some View {
        NavigationStack(path: $sceneProvider.path) {
            StandingsListView
                .configure(with: dataProvider.mlbAPIRepository)
                .withSceneProvider()
        }
        .environmentObject(sceneProvider)
    }
}
