//
//  LineScoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation
import SwiftUI

struct LinescoreGridViewModel {
    
    static let empty: [LineScoreViewItem] = [
        LineScoreViewItem(type: .team, value: ""),
        LineScoreViewItem(type: .none, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .none, value: ""),
        LineScoreViewItem(type: .stat, value: ""),
        LineScoreViewItem(type: .stat, value: ""),
        LineScoreViewItem(type: .stat, value: "")
    ]
    
    var headers: [LineScoreViewItem]
    var homeLineItems: [LineScoreViewItem]
    var awayLineItems: [LineScoreViewItem]
}

extension LinescoreGridViewModel {
    init(homeAbbreviation: String, awayAbbreviation: String, _ linescore: Linescore) {
        
        var spacer: LineScoreViewItem {
            LineScoreViewItem(id: UUID(), type: .none, value: "")
        }
        
        var awayLineItems = [LineScoreViewItem]()
        var homeLineItems = [LineScoreViewItem]()
        var headerLineItems = [LineScoreViewItem]()
        
        let a_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: awayAbbreviation)
        let h_nameAbbreviation = LineScoreViewItem(id: UUID(), type: .team, value: homeAbbreviation)
        
        // Teams
        awayLineItems.append(a_nameAbbreviation)
        homeLineItems.append(h_nameAbbreviation)
        headerLineItems.append(spacer)
        
        homeLineItems.append(spacer)
        awayLineItems.append(spacer)
        headerLineItems.append(spacer)
        
        // Add empty innings if game is in progress
        var innings = linescore.innings
        if innings.count < 9 {
            var nextInningNumber = innings.count + 1
            while innings.count < 9 {
                let inning = Linescore.Inning(home: .init(),
                                              away: .init(),
                                              num: nextInningNumber)
                
                nextInningNumber += 1
                innings.append(inning)
            }
        }
        
        // Innings
        for inning in innings {
            let homeInningRuns = inning.away.runs
            let awayInningRuns = inning.home.runs
            
            let h_runItem = LineScoreViewItem(id: UUID(), type: .run, value: homeInningRuns.formattedStat())
            let a_runItem = LineScoreViewItem(id: UUID(), type: .run, value: awayInningRuns.formattedStat())
            let headerItem = LineScoreViewItem(id: UUID(), type: .header, value: String(inning.num))
            
            awayLineItems.append(a_runItem)
            homeLineItems.append(h_runItem)
            headerLineItems.append(headerItem)
        }
        
        // Spacer
        awayLineItems.append(spacer)
        homeLineItems.append(spacer)
        headerLineItems.append(spacer)
        
        // Runs
        let runsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "R")
        headerLineItems.append(runsHeaderItem)
        
        let h_runsTotal = linescore.homeTotal?.runs
        let h_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: h_runsTotal.formattedStat())
        homeLineItems.append(h_runsTotalItem)
        
        let a_runsTotal = linescore.awayTotal?.runs
        let a_runsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: a_runsTotal.formattedStat())
        awayLineItems.append(a_runsTotalItem)
        
        // Hits
        let hitsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "H")
        headerLineItems.append(hitsHeaderItem)
        
        let h_hitsTotal = linescore.homeTotal?.hits
        let h_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: h_hitsTotal.formattedStat())
        homeLineItems.append(h_hitsTotalItem)
        
        let a_hitsTotal = linescore.awayTotal?.hits
        let a_hitsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: a_hitsTotal.formattedStat())
        awayLineItems.append(a_hitsTotalItem)
        
        // Errors
        let errorsHeaderItem = LineScoreViewItem(id: UUID(), type: .header, value: "E")
        headerLineItems.append(errorsHeaderItem)
        
        let h_errorsTotal = linescore.homeTotal?.errors
        let h_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: h_errorsTotal.formattedStat())
        homeLineItems.append(h_errorsTotalItem)
        
        let a_errorsTotal = linescore.awayTotal?.errors
        let a_errorsTotalItem = LineScoreViewItem(id: UUID(), type: .stat, value: a_errorsTotal.formattedStat())
        awayLineItems.append(a_errorsTotalItem)
        
        self = LinescoreGridViewModel(headers: headerLineItems,
                                      homeLineItems: homeLineItems,
                                      awayLineItems: awayLineItems)
    }
}
