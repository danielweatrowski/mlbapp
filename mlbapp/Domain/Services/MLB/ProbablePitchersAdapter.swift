//
//  ProbablePitchersAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation
import SwiftMLB
import Models

struct ProbablePitchersAdapter {
    
    let dataObject: MLBProbablePitcher?
    
    /// Returns `ProbablePitchers` domain object if dataObject is non-nil. Returns nil if `dataObject` is nil.
    func toDomain() -> ProbablePitchers? {
        
        guard let ppDTO = dataObject else {
            return nil
        }
        
        var homePitcher: Person?
        if let homePitcherDTO = ppDTO.home {
            homePitcher = Person(id: homePitcherDTO.id, fullName: homePitcherDTO.fullName)
        }
        
        var awayPitcher: Person?
        if let awayPitcherDTO = ppDTO.away {
            awayPitcher = Person(id: awayPitcherDTO.id, fullName: awayPitcherDTO.fullName)
        }
        
        return ProbablePitchers(home: homePitcher,
                                away: awayPitcher)
    }
}
