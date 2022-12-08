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
    
    var data: [LineScoreViewItem] {
        return homeLineItems + awayLineItems
    }
    
    var columns: [GridItem] {
        let firstColumn = [GridItem(.fixed(40))]
        
        let innings = homeLineItems.map({$0.type}).filter({$0 == .run})
        let totalInnings = innings.count
        let inningColumns = Array(repeating: GridItem(.flexible()), count: totalInnings)
        let statColumns = [GridItem(.fixed(8)), GridItem(.fixed(16)), GridItem(.fixed(16)), GridItem(.fixed(16))]
        
        return firstColumn + inningColumns + statColumns
    }
    
    var headers: [LineScoreViewItem]
    var homeLineItems: [LineScoreViewItem]
    var awayLineItems: [LineScoreViewItem]

}
