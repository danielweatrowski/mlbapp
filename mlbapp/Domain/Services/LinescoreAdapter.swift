//
//  LinescoreAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation


struct LinescoreAdapter {
    
    let dataObject: MLBLinescore
    
    func toDomain() -> Linescore {
        let innings: [Linescore.Inning] = dataObject.innings.map { inningDTO in
            
            let homeItem = Linescore.LineItem(runs: inningDTO.home.runs ?? -1,
                                              hits: inningDTO.home.hits ?? -1,
                                              errors: inningDTO.home.hits ?? -1)
            
            let awayItem = Linescore.LineItem(runs: inningDTO.away.runs ?? -1,
                                              hits: inningDTO.away.hits ?? -1,
                                              errors: inningDTO.away.hits ?? -1)
            
            return Linescore.Inning(home: homeItem,
                                    away: awayItem,
                                    num: inningDTO.num)
        }
        
        let homeTotal = Linescore.LineItem(runs: dataObject.homeTotal.runs ?? -1,
                                           hits: dataObject.homeTotal.hits ?? -1,
                                           errors: dataObject.homeTotal.errors ?? -1)
        
        let awayTotal = Linescore.LineItem(runs: dataObject.awayTotal.runs ?? -1,
                                           hits: dataObject.awayTotal.hits ?? -1,
                                           errors: dataObject.awayTotal.errors ?? -1)
        
        return Linescore(innings: innings,
                         homeTotal: homeTotal,
                         awayTotal: awayTotal)
    }
}
