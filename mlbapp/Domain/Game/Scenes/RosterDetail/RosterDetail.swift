//
//  RosterDetail.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation
import Models
import Common

enum RosterDetail {
    
    enum State {
        case loading, loaded, error
    }
    
    class ViewModel: ObservableObject {
        let navigationTitle = "Rosters"
        
        @Published var state: State = .loaded
        @Published var teamSelection: Int = 0
        @Published var searchText: String = ""
        
        @Published var homeRoster: [RosterRowViewModel] = []
        @Published var awayRoster: [RosterRowViewModel] = []
        
        @Published var sceneError: SceneError = SceneError()

    }
    
    struct Output {
        let homeRoster: Roster
        let awayRoster: Roster
    }
}
