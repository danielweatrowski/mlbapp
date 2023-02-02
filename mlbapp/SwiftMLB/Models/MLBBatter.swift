//
//  Batter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct MLBBatter: Codable {
    let personID: Int
    // TODO: Get last name
    let fullName: String
    let positionAbbreviation: String
    let battingOrder: String?
    let stats: BattingStats?
}

struct BattingStats: Codable {
    let runs, doubles, triples, homeRuns, hits: Int
    let strikeOuts, baseOnBalls, stolenBases: Int
    let atBats, rbi, leftOnBase: Int
    let avg, slg, ops, obp: String
    let note: String?
}
