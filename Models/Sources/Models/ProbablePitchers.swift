//
//  ProbablePitchers.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation

public struct ProbablePitchers: Codable {
    
    public init(home: Person? = nil, away: Person? = nil) {
        self.home = home
        self.away = away
    }
    
    public let home: Person?
    public let away: Person?
    
    public var hasPitcherData: Bool {
        return home != nil || away != nil
    }
}
