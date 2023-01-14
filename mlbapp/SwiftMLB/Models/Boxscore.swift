//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct Boxscore: Codable {
    let gameId: String
    let homeBatters: [Batter]
    let awayBatters: [Batter]
    let homePitchers: [Pitcher]
    let awayPitchers: [Pitcher]
    let homeBattingTotals: BattingStats
    let awayBattingTotals: BattingStats
    let homePitchingTotals: PitchingStats
    let awayPitchingTotals: PitchingStats
    let homeNotes: [String]
    let awayNotes: [String]
}
