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
        @Published var filterType: ScoresList.FilterType = .all

        @Published var selectedDate = Date()
        @Published var showCalendarSheet: Bool = false
        @Published var rows: [ListGameRowViewModel]?
        
        @Published var sceneError: SceneError = SceneError()
        
        var filteredRows: [ListGameRowViewModel]? {
            switch filterType {
            case .all:
                return rows
            case .inProgess:
                return rows?.filter({$0.gameStatus == .live})
            case .final:
                return rows?.filter({$0.gameStatus == .final})
            }
        }
    }
    
    struct Output {
        let results: [GameSearch.Result]
    }
    
    enum FilterType: CaseIterable, Identifiable, CustomStringConvertible {
        case all, inProgess, final
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .all: return "All"
            case .inProgess: return "In Progress"
            case .final: return "Final"
            }
        }
    }
     
}
