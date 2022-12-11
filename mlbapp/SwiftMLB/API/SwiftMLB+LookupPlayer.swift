//
//  SwiftMLB+LookupPlayer.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/9/22.
//

import Foundation

extension SwiftMLB {
    
    static func lookupPlayer(with term: String, season: String? = nil) {
        if season == nil {
            // TODO: Get current season year
        }
        let request: MLBRequest = .players("2022")
        
    }
}
