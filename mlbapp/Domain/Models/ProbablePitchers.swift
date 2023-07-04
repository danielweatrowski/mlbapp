//
//  ProbablePitchers.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation

struct ProbablePitchers: Codable {
    
    struct Pitcher: Codable {
        let id: Int
        let fullName: String
    }
    
    let home: Pitcher?
    let away: Pitcher?
    
    var hasPitcherData: Bool {
        return home != nil || away != nil
    }
}
