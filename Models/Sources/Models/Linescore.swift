//
//  Linescore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

public struct Linescore: Codable {
    
    public struct Inning: Codable {
        public init(home: Linescore.LineItem, away: Linescore.LineItem, num: Int) {
            self.home = home
            self.away = away
            self.num = num
        }
        
        public var home: LineItem
        public var away: LineItem
        public var num: Int
    }
    
    public struct LineItem: Codable {
        public init(runs: Int? = nil, hits: Int? = nil, errors: Int? = nil) {
            self.runs = runs
            self.hits = hits
            self.errors = errors
        }
        
        public var runs: Int?
        public var hits: Int?
        public var errors: Int?
    }
    
    public var innings: [Inning]
    public var homeTotal: LineItem?
    public var awayTotal: LineItem?
    
    public init(innings: [Linescore.Inning], homeTotal: Linescore.LineItem? = nil, awayTotal: Linescore.LineItem? = nil) {
        self.innings = innings
        self.homeTotal = homeTotal
        self.awayTotal = awayTotal
    }
}


