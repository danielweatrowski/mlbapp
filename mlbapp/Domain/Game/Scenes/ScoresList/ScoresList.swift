//
//  ScoresList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import SwiftUI

enum ScoresList {
    
    class ViewModel: ObservableObject {
        
        enum State {
            case loading, loaded, error
        }
        
        let navigationTitle = "Scores"
        @Published var state: State = .loading
        @Published var filterType: ScoresList.FilterType = .all
        @Published var listType: ScoresList.ListType = .grid

        @Published var selectedDate = Date()
        @Published var showCalendarSheet: Bool = false
        
        var listItems: [ScoresListItemViewModel] = []
        
        @Published var sceneError: SceneError = SceneError()
        
        // TOTO: REIMPLEMENT
//        var filteredItems: [ListGameRowViewModel]? {
//            switch filterType {
//            case .all:
//                return rows
//            case .inProgess:
//                return rows?.filter({$0.gameStatus == .live})
//            case .final:
//                return rows?.filter({$0.gameStatus == .final})
//            }
//        }
        
        var selectedColumns: [GridItem] {
            switch listType {
            case .list:
                return [
                    GridItem(.flexible(), spacing: 0)
                ]
            case .grid:
                return [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
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
    
    enum ListType: CaseIterable, Identifiable, CustomStringConvertible {
        case grid, list
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .grid: return "Grid"
            case .list: return "List"
            }
        }
    }
     
}
