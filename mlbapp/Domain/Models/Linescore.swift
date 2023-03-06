//
//  Linescore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct Linescore {
    
    struct Inning: Codable {
        var home: LineItem
        var away: LineItem
        var num: Int
    }
    
    struct LineItem: Codable {
        var runs: Int
        var hits: Int
        var errors: Int
    }
    
    var innings: [Inning]
    var homeTotal: LineItem
    var awayTotal: LineItem
    
//    var winner: MLBPitcher?
//    var loser: MLBPitcher?
    
}


