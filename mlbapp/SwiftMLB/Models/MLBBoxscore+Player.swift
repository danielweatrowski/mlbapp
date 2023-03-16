//
//  MLBBoxscore+Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/10/23.
//

import Foundation

extension MLBBoxscore {
    struct Player: Codable {
        let id: Int
        let fullName: String
        let jerseyNumber: String
        let battingOrder: String?
        let seasonStats: MLBStatistics.TotalStats
        let stats: MLBStatistics.GameStats?
        let position: MLBPosition
    }
}
