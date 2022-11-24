//
//  LineScore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

struct LineScore: Codable {
    
    struct Keys {
        static let teams = "teams"
        static let innings = "innings"
        static let home = "home"
        static let away = "away"
    }
    
    struct Inning: Codable {
        
        struct Keys {
            static let home = "home"
            static let away = "away"
            static let num = "num"
        }
        
        var homeTeam: LineItem
        var awayTeam: LineItem
        var num: Int
    }
    
    struct LineItem: Codable {
        
        struct Keys {
            static let hits = "hits"
            static let runs = "runs"
            static let errors = "errors"
            static let leftOnBase = "leftOnBase"
        }
        
        var runs: Int?
        var hits: Int?
        var errors: Int?
        var leftOnBase: Int?
    }
    
    var innings: [Inning]
    var homeLine: LineItem
    var awayLine: LineItem
}

extension LineScore {
    
    init(dictionary: [String: Any]) throws {
        guard let inningsDict = dictionary[LineScore.Keys.innings] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: LineScore.Keys.innings)
        }
        
        guard let teamsDict = dictionary[LineScore.Keys.teams] as? [String: Any] else {
            throw SwiftMLBError.keyNotFound(key: LineScore.Keys.teams)
        }
        
        guard let homeDict = teamsDict[LineScore.Keys.home] as? [String: Int] else {
            throw SwiftMLBError.keyNotFound(key: LineScore.Keys.home)
        }
        
        guard let awayDict = teamsDict[LineScore.Keys.away] as? [String: Int] else {
            throw SwiftMLBError.keyNotFound(key: LineScore.Keys.away)
        }
        
        let homeItem = LineScore.LineItem(runs: homeDict[LineScore.LineItem.Keys.runs],
                                hits: homeDict[LineScore.LineItem.Keys.hits],
                                errors: homeDict[LineScore.LineItem.Keys.errors],
                                leftOnBase: homeDict[LineScore.LineItem.Keys.leftOnBase])

        let awayItem = LineScore.LineItem(runs: awayDict[LineScore.LineItem.Keys.runs],
                                hits: awayDict[LineScore.LineItem.Keys.hits],
                                errors: awayDict[LineScore.LineItem.Keys.errors],
                                leftOnBase: awayDict[LineScore.LineItem.Keys.leftOnBase])

        var innings = [LineScore.Inning]()
        
        for d in inningsDict {
            let homeLine = d[LineScore.Inning.Keys.home] as! [String: Int]
            let awayLine = d[LineScore.Inning.Keys.away] as! [String: Int]
            let inningNumber = d[LineScore.Inning.Keys.num] as! Int
            
            let homeItem = LineScore.LineItem(runs: homeLine[LineScore.LineItem.Keys.runs],
                                    hits: homeLine[LineScore.LineItem.Keys.hits],
                                    errors: homeLine[LineScore.LineItem.Keys.errors],
                                    leftOnBase: homeLine[LineScore.LineItem.Keys.leftOnBase])

            let awayItem = LineScore.LineItem(runs: awayLine[LineScore.LineItem.Keys.runs],
                                              hits: awayLine[LineScore.LineItem.Keys.hits],
                                              errors: awayLine[LineScore.LineItem.Keys.errors],
                                              leftOnBase: awayLine[LineScore.LineItem.Keys.leftOnBase])
            
            let inning = LineScore.Inning(homeTeam: homeItem,
                                          awayTeam: awayItem,
                                          num: inningNumber)
            innings.append(inning)
        }
        
        self = LineScore(innings: innings,
                         homeLine: homeItem,
                         awayLine: awayItem)
    }
}
