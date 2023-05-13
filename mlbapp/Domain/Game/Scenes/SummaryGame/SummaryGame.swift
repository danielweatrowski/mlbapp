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
        let eventName: String
        let description: String
        let numberOfOuts: String?
    }
    
    class ViewModel: ObservableObject {
        
        init(gameID: Int) {
            self.gameID = gameID
        }
        
        var gameID: Int
        @Published var sections: [InningSectionViewModel] = []
    }
    
    struct Output<P: PlayProtocol> {
        var plays: [P]
    }
}
