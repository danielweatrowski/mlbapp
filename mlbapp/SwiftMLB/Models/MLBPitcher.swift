//
//  Pitcher.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/14/23.
//

import Foundation

struct MLBPitcher: Codable {
    let personID: Int
    let fullName: String
    let stats: PitchingStats?
}

struct PitchingStats: Codable {
    let doubles, triples, homeRuns, hits: Int
    let strikeOuts, baseOnBalls, stolenBases: Int
    let atBats, rbi, runs: Int
    let strikes, balls, numberOfPitches, battersFaced: Int
    let inningsPitched, era: String
    let wins, holds, losses, blownSaves, saves: Int?
    let note: String?
}
