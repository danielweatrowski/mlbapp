//
//  ListGameModels.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation

enum ListGame {
    
    class ViewModel: ObservableObject {
        @Published var rows: [ListGameRowViewModel]?
    }
    
    struct Response {
        var results: [GameSearch.Result]
    }
}
