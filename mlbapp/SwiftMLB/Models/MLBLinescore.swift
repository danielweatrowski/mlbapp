//
//  LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct MLBLinescore: Codable {
    
    struct Inning: Codable {
        
        var home: LineItem
        var away: LineItem
        var num: Int
    }
    
    struct LineItem: Codable {
        var runs: Int?
        var hits: Int?
        var errors: Int?
        var leftOnBase: Int?
    }
    
    struct Teams: Codable {
        var home: LineItem?
        var away: LineItem?
    }
    
    var innings: [Inning]
    var teams: Teams
//    var home: LineItem?
//    var away: LineItem?
    var winner: MLBPitcher?
    var loser: MLBPitcher?
}
