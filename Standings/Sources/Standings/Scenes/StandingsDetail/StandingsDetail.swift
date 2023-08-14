//
//  StandingsDetail.swift
//  
//
//  Created by Daniel Weatrowski on 8/13/23.
//

import Foundation
import Models

enum StandingsDetail {
    
    enum Item {
        case wins, losses, winningPCT, gamesBehind, wildcardGamesBehind, last10
        case runsAllowed, runsScored, runDiff
        case xRecord, xSeasonRecord
    }
    
    struct ItemViewModel {
        var item: Item
        var value: String
    }
    
    struct SectionViewModel {
        let title: String
        let items: [ItemViewModel]
    }
    
    struct Output {
        let standing: Standings.TeamRecord
    }
    
    struct ViewInput {
        let sections: [SectionViewModel]
    }

}
