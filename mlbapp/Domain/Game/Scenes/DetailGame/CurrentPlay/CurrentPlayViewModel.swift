//
//  CurrentPlayViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/10/23.
//

import Foundation

struct CurrentPlayViewModel {
    
    let batterTitleText: String = "Batting"
    let batterNameText: String
    let batterStatsText1: String
    let batterStatsText2: String
    
    let pitcherTitleText: String = "Pitching"
    let pitcherNameText: String
    let pitcherStatsText1: String
    let pitcherStatsText2: String

    var numberOfOuts: Int = 0
    let countText: String
    
    let pitchSequenceRows: [PitchSequenceViewModel.PitchRow]
    var pitchSequenceViewModel: PitchSequenceViewModel? {
        return pitchSequenceRows.isEmpty ? nil : .init(rows: pitchSequenceRows)
    }
    
    let onDeckTitleText = "On-deck:"
    let onDeckBatterNameText: String?
    
    var isRunnerOn1B: Bool = false
    var isRunnerOn2B: Bool = false
    var isRunnerOn3B: Bool = false
    
    let outIndicatorWidth: CGFloat = 10
    let baseIndicatorWidth: CGFloat = 20
}
