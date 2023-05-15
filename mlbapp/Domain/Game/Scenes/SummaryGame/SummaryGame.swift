//
//  SummaryGame.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

struct SummaryGame {
    
    struct InningSectionViewModel: Identifiable {
        let id = UUID()
        var inningNumber: Int
        var inningName: String
        var plays: [InningPlayViewModel]
    }
    
    struct InningPlayViewModel: Identifiable {
        let id = UUID()
        let playID: Int
        let eventName: String
        let description: String
        let time: String
        let numberOfOuts: String?
    }
    
    class ViewModel: ObservableObject {
        
        enum State {
            case loading, loaded, error
        }
        
        init(gameID: Int) {
            self.gameID = gameID
        }
        
        var gameID: Int
        let navigationTitle = "Summary"
        @Published var state: State = .loading
        @Published var sections: [InningSectionViewModel] = []
    }
    
    struct Output<P: PlayProtocol> {
        var plays: [P]
    }
}
