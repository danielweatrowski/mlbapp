//
//  DetailGameHeaderViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import SwiftUI
import Views

struct DetailGameHeaderViewModel {
    
    var homeTeamID: Int = 0
    var homeTeamName: String = ""
    var homeTeamAbbreviation = ""
    var homeTeamScore: String = ""
    var homeTeamRecord: String = ""
    var awayTeamID: Int = 0
    var awayTeamName: String = ""
    var awayTeamAbbreviation = ""
    var awayTeamScore: String = ""
    var awayTeamRecord: String = ""
    
    var statusBannerViewModel: StatusBannerViewModel?
    
}

