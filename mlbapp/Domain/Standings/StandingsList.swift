//
//  StandingsList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import Foundation


enum StandingsList {
    
    enum State {
        case loading, loaded, error
    }
    
    class ViewModel: ObservableObject {
        @Published var state: State = .loaded
        @Published var selectedLeague: Int = 0
        let navigationTitle: String = "Standings"
        // errors
        @Published var sceneError: SceneError = SceneError()
    }
}
