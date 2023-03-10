//
//  MLBBoxscore+Team.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation

extension MLBBoxscore {
    struct Team: Codable {
        let batters: [Player]
        let pitchers: [Player]
        let bench: [Player]
        let bullpen: [Player]
        
        let stats: MLBStatistics.TotalStats
        let notes: [String]
        let battingInfo: [BoxscoreInfo]
        let fieldingInfo: [BoxscoreInfo]
    }
}
