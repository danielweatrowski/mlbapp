//
//  ScoresTab.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/12/23.
//

import SwiftUI
import Common

struct ScoresTab: View {
    
    @StateObject var sceneProvider = SceneProvider()
    let dataProvider: DataProvider

    var body: some View {
        NavigationStack(path: $sceneProvider.path) {
            ScoresListView
                .configure(gameStore: dataProvider.mlbAPIRepository)
                .withSceneSheetProvider(sheetItem: $sceneProvider.presentedSheet)
                .withSceneProvider()
        }
        .environmentObject(sceneProvider)
    }
}
