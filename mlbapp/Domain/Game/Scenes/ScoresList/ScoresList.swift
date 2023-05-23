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
        @Published var rows: [ListGameRowViewModel]?
    }
    
    struct Output {
        let results: [GameSearch.Result]
    }
     
}
