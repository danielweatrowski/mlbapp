//
//  LineScoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation
import SwiftUI

struct LineScoreViewModel {
    
    static let empty: [LineScoreViewItem] = [
        LineScoreViewItem(type: .team, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .run, value: ""),
        LineScoreViewItem(type: .none, value: ""),
        LineScoreViewItem(type: .stat, value: ""),
        LineScoreViewItem(type: .stat, value: ""),
        LineScoreViewItem(type: .stat, value: "")
    ]
    
    var headers: [LineScoreViewItem]
    var homeLineItems: [LineScoreViewItem]
    var awayLineItems: [LineScoreViewItem]
    var winningPitcherName: String?
    var winningPitcherWins: Int?
    var winningPitcherLosses: Int?
    var winningPitcherERA: String?
    var losingPitcherName: String?
    var losingPitcherWins: Int?
    var losingPitcherLosses: Int?
    var losingPitcherERA: String?
}