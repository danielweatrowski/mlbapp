//
//  DecisionsInfoViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/11/23.
//

import Foundation

struct DecisionsInfoViewModel {
    var winningPitcherName: String
    var winningPitcherWins: Int
    var winningPitcherLosses: Int
    var winningPitcherERA: String
    var losingPitcherName: String
    var losingPitcherWins: Int
    var losingPitcherLosses: Int
    var losingPitcherERA: String
    var savingPitcherName: String? = nil
    var savingPitcherWins: Int = 0
    var savingPitcherLosses: Int = 0
    var savingPitcherERA: String = ""
}

extension DecisionsInfoViewModel {

    var includeSaveDecision: Bool {
        savingPitcherName != nil
    }
}
