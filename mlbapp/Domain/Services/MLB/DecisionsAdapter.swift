//
//  DecisionsAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation
import SwiftMLB

struct DecisionsAdapter {
    
    let dataObject: MLBGameDecision?
    
    func toDomain() -> Decisions? {
        
        var decisions: Decisions?
        var save: Decisions.Player?
        if let decisionsDTO = dataObject {
            
            if let saverDTO = decisionsDTO.save {
                save = .init(id: saverDTO.id, fullName: saverDTO.fullName)
            }
            
            decisions = .init(winner: .init(id: decisionsDTO.winner?.id ?? 0,
                                            fullName: decisionsDTO.winner?.fullName ?? "Unknown"),
                              loser: .init(id: decisionsDTO.loser?.id ?? 0,
                                           fullName: decisionsDTO.loser?.fullName ?? "Unknown"),
                              save: save)
        }
        
        return decisions
    }
}

