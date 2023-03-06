//
//  LineScoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation
import SwiftUI

struct LinescoreGridViewModel {
    
    static let empty: [LineScoreViewItem] = [
        LineScoreViewItem(type: .team, value: ""),
        LineScoreViewItem(type: .none, value: ""),
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
}