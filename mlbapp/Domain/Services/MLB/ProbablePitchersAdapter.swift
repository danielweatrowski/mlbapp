//
//  ProbablePitchersAdapter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation
import SwiftMLB

struct ProbablePitchersAdapter {
    
    let dataObject: MLBProbablePitcher?
    
    /// Returns `ProbablePitchers` domain object if dataObject is non-nil. Returns nil if `dataObject` is nil.
    func toDomain() -> ProbablePitchers? {
        
        guard let ppDTO = dataObject else {
            return nil
        }
        
        var homePitcher: ProbablePitchers.Pitcher?
        if let homePitcherDTO = ppDTO.home {
            homePitcher = ProbablePitchers.Pitcher(id: homePitcherDTO.id, fullName: homePitcherDTO.fullName)
        }
        
        var awayPitcher: ProbablePitchers.Pitcher?
        if let awayPitcherDTO = ppDTO.away {
            awayPitcher = ProbablePitchers.Pitcher(id: awayPitcherDTO.id, fullName: awayPitcherDTO.fullName)
        }
        
        
        return ProbablePitchers(home: homePitcher,
                                away: awayPitcher)
    }
}
