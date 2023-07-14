//
//  StandingsTab.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/12/23.
//

import SwiftUI

struct StandingsTab: View {
    
    @StateObject var router = Router()
    let dataProvider: DataProvider
    
    var body: some View {
        NavigationStack(path: $router.path) {
            StandingsListView
                .configure(with: dataProvider.mlbAPIRepository)
                .withRouter()
        }
        .environmentObject(router)
    }
}
