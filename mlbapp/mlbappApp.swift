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
            NavigationView {
                DetailGameConfigurator.configure(for: Seeds.Games.PHI_NYM_20190424.id)
            }
        }

    }
}
