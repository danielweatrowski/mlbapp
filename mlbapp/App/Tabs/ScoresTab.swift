//
//  ScoresTab.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/12/23.
//

import SwiftUI

struct ScoresTab: View {
    
    @StateObject var router = Router()
    let dataProvider: DataProvider

    var body: some View {
        NavigationStack(path: $router.path) {
            ScoresListView
                .configure(gameStore: dataProvider.mlbAPIRepository)
                .withRouterSheets(sheetItem: $router.presentedSheet)
                .withRouter()
        }
        .environmentObject(router)
    }
}
