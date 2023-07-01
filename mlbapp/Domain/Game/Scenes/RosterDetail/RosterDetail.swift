//
//  RosterDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

enum RosterDetail {
    
    enum State {
        case loading, loaded, error
    }
    
    class ViewModel: ObservableObject {
        let navigationTitle = "Rosters"
        
        @Published var state: State = .loading
        @Published var teamSelection: Int = 0
        @Published var sceneError: SceneError = SceneError()

    }
    
    struct Output {
        
    }
}
