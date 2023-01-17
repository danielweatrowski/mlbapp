//
//  Boxscore.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct MLBBoxscore: Codable {
    let gameId: String
    let homeBatters: [MLBBatter]
    let awayBatters: [MLBBatter]
    let homePitchers: [MLBPitcher]
    let awayPitchers: [MLBPitcher]
    let homeBattingTotals: BattingStats
    let awayBattingTotals: BattingStats
    let homePitchingTotals: PitchingStats
    let awayPitchingTotals: PitchingStats
    let homeNotes: [String]
    let awayNotes: [String]
}
