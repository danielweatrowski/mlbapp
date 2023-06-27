//
//  CurrentPlayViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/10/23.
//

import Foundation

struct CurrentPlayViewModel {
    var numberOfOuts: Int = 0
    let countText: String
    
    let batterTitleText: String = "Batting"
    let batterNameText: String
    let batterStatsText: String
    
    let pitcherTitleText: String = "Pitching"
    let pitcherNameText: String
    let pitcherStatsText: String
    
    var isRunnerOn1B: Bool = false
    var isRunnerOn2B: Bool = false
    var isRunnerOn3B: Bool = false
    
    let outIndicatorWidth: CGFloat = 10
    let baseIndicatorWidth: CGFloat = 20
}
