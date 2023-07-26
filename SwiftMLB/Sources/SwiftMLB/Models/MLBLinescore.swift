//
//  LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

public struct MLBLinescore: Codable {
    
    public struct Inning: Codable {
        
        public var home: LineItem
        public var away: LineItem
        public var num: Int
    }
    
    public struct LineItem: Codable {
        public var runs: Int?
        public var hits: Int?
        public var errors: Int?
        public var leftOnBase: Int?
    }
    
    public struct Teams: Codable {
        public var home: LineItem?
        public var away: LineItem?
    }
    
    public var innings: [Inning]
    public var teams: Teams
    public var currentInning: Int?
    public var currentInningOrdinal: String?
    public var inningState: String?
    public var inningHalf: String?
//    var home: LineItem?
//    var away: LineItem?
//    var winner: MLBPitcher?
//    var loser: MLBPitcher?
}
