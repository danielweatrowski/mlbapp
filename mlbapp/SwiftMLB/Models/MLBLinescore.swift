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
    
    var innings: [Inning]
    var homeTotal: LineItem
    var awayTotal: LineItem
}
