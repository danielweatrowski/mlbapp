//
//  LinescoreAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation
import SwiftMLB
import Models


struct LinescoreAdapter {
    
    let dataObject: MLBLinescore
    
    func toDomain() -> Linescore {
        let innings: [Linescore.Inning] = dataObject.innings.map { inningDTO in
            
            let homeItem = Linescore.LineItem(runs: inningDTO.home.runs,
                                              hits: inningDTO.home.hits,
                                              errors: inningDTO.home.errors)
            
            let awayItem = Linescore.LineItem(runs: inningDTO.away.runs,
                                              hits: inningDTO.away.hits,
                                              errors: inningDTO.away.errors)
            
            return Linescore.Inning(home: homeItem,
                                    away: awayItem,
                                    num: inningDTO.num)
        }
        
        let homeTotal = Linescore.LineItem(runs: dataObject.teams.home?.runs,
                                           hits: dataObject.teams.home?.hits,
                                           errors: dataObject.teams.home?.errors)
        
        let awayTotal = Linescore.LineItem(runs: dataObject.teams.away?.runs,
                                           hits: dataObject.teams.away?.hits,
                                           errors: dataObject.teams.away?.errors)
        
        return Linescore(innings: innings,
                         homeTotal: homeTotal,
                         awayTotal: awayTotal)
    }
}
