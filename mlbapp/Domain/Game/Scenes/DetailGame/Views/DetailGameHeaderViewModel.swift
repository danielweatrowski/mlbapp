//
//  DetailGameHeaderViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import SwiftUI

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
    
    var gameDate: String = ""
    var venueName: String = ""
    
    var statusText: String?
    var statusBackgroundColor: Color?
    
    var showStatusBanner: Bool {
        return statusText != nil && statusText?.isEmpty == false && statusBackgroundColor != nil
    }
    
}

