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
        case home, away, lastTen, extraInnings, american, national
        case xRecord, xSeasonRecord
        
        var title: String {
            get {
                switch self {
                case .wins:
                    return "Wins"
                case .losses:
                    return "Losses"
                case .winningPCT:
                    return "Winning Percentage"
                case .gamesBehind:
                    return "Games Back"
                case .wildcardGamesBehind:
                    return "Wildcard Games Back"
                case .last10:
                    return "Last 10"
                case .runDiff:
                    return "Run Differential"
                case .runsAllowed:
                    return "Runs Allowed"
                case .runsScored:
                    return "Runs Scored"
                case .home:
                    return "Home"
                case .away:
                    return "Away"
                case .american:
                    return "American League"
                case .national:
                    return "National League"
                case .extraInnings:
                    return "Extra Innings"
                case .xRecord:
                    return "xWinLoss"
                case .xSeasonRecord:
                    return "Season xWinLoss"
                default: return ""
                }
            }
        }
    }
    
    struct ItemViewModel: Hashable {
        var item: Item
        var value: String
    }
    
    struct SectionViewModel: Hashable {
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
