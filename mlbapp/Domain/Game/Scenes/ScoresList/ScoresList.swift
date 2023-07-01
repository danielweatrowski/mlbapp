//
//  ScoresList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import Foundation

enum ScoresList {
    
    class ViewModel: ObservableObject {
        
        enum State {
            case loading, loaded, error
        }
        
        let navigationTitle = "Scores"
        @Published var state: State = .loading
        @Published var selectedDate = Date()
        @Published var showCalendarSheet: Bool = false
        @Published var rows: [ListGameRowViewModel]?
        
        @Published var sceneError: SceneError = SceneError()
    }
    
    struct Output {
        let results: [GameSearch.Result]
    }
     
}
