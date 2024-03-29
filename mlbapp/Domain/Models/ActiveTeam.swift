//
//  ActiveTeam.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation


enum ActiveTeam: Int, CaseIterable, Identifiable {
    case any
    case unknown
    case dodgers
    case yankees
    case rangers
    case mets
    case pirates
    case mariners
    case padres
    case cardinals
    case giants
    case rays
    case blueJays
    case twins
    case phillies
    case braves
    case whiteSox
    case marlins
    case brewers
    case diamondbacks
    case rockies
    case angels
    case guardians
    case cubs
    case reds
    case nationals
    case tigers
    case royals
    case astros
    case orioles
    case athletics
    case redSox

    var id: Int {
        switch(self) {
        case .any: return 0
        case .unknown: return Int.max
        case .dodgers: return 119
        case .rangers: return 140
        case .mets: return 121
        case .pirates: return 134
        case .mariners: return 136
        case .padres: return 135
        case .cardinals: return 138
        case .giants: return 137
        case .rays: return 139
        case .blueJays: return 141
        case .twins: return 142
        case .phillies: return 143
        case .braves: return 144
        case .whiteSox: return 145
        case .marlins: return 146
        case .yankees: return 147
        case .brewers: return 158
        case .diamondbacks: return 109
        case .rockies: return 115
        case .angels: return 108
        case .guardians: return 114
        case .cubs: return 112
        case .reds: return 113
        case .nationals: return 120
        case .tigers: return 116
        case .royals: return 118
        case .astros: return 117
        case .orioles: return 110
        case .athletics: return 133
        case .redSox: return 111
        }
    }
    
    var name: String {
        switch(self) {
        case .any: return "Any"
        case .unknown: return "Unknown"
        case .dodgers: return "Los Angeles Dodgers"
        case .mets: return "New York Mets"
        case .rangers: return "Texas Rangers"
        case .pirates: return "Pitsburg Pirates"
        case .mariners: return "Seattle Mariners"
        case .padres: return "San Diego Padres"
        case .cardinals: return "St. Louis Cardinals"
        case .giants: return "San Francisco Giants"
        case .rays: return "Tampa Bay Rays"
        case .blueJays: return "Toronto Blue Jays"
        case .twins: return "Minnesota Twins"
        case .phillies: return "Philadelphia Phillies"
        case .braves: return "Atlanta Braves"
        case .whiteSox: return "Chicago White Sox"
        case .marlins: return "Miami Marlins"
        case .yankees: return "New York Yankees"
        case .brewers: return "Milwaukee Brewers"
        case .diamondbacks: return "Arizona Diamondbacks"
        case .rockies: return "Colorado Rockies"
        case .angels: return "Los Angeles Angels"
        case .guardians: return "Cleveland Guardians"
        case .cubs: return "Chicago Cubs"
        case .reds: return "Cincinnati Reds"
        case .nationals: return "Washington Nationals"
        case .tigers: return "Detroit Tigers"
        case .royals: return "Kansas City Royals"
        case .astros: return "Houston Astros"
        case .orioles: return "Baltimore Orioles"
        case .athletics: return "Oakland Athletics"
        case .redSox: return "Boston Red Sox"
        }
    }
    
    var abbreviation : String {
        switch(self) {
        case .unknown: return "NA"
        case .any: return "ANY"
        case .dodgers: return "LAD"
        case .mets: return "NYM"
        case .rangers: return "TEX"
        case .pirates: return "PIT"
        case .mariners: return "SEA"
        case .padres: return "SD"
        case .cardinals: return "STL"
        case .giants: return "SF"
        case .rays: return "TB"
        case .blueJays: return "TOR"
        case .twins: return "MIN"
        case .phillies: return "PHI"
        case .braves: return "ATL"
        case .whiteSox: return "CWS"
        case .marlins: return "MIA"
        case .yankees: return "NYY"
        case .brewers: return "MIL"
        case .diamondbacks: return "ARI"
        case .rockies: return "COL"
        case .angels: return "LAA"
        case .guardians: return "CLE"
        case .cubs: return "CHC"
        case .reds: return "CIN"
        case .nationals: return "WSH"
        case .tigers: return "DET"
        case .royals: return "KC"
        case .astros: return "HOU"
        case .orioles: return "BAL"
        case .athletics: return "OAK"
        case .redSox: return "BOS"
        }
    }
    
    var primaryColor: String {
        switch self {
        case .giants: return "FD5A1E"
        case .dodgers: return "005A9C"
        case .mariners: return "005C5C"
        case .guardians: return "e31937"
        case .phillies: return "E81828"
        case .mets: return "FF5910"
        case .padres: return "ffc427"
        default: return "FFFFFF"
        }
    }
    
    // TODO: Switch on light/dark mode
    var logoURL: String {
        switch(self) {
        case .dodgers: return "https://www.mlbstatic.com/team-logos/team-cap-on-light/119.svg"
        case .mets: return "https://www.mlbstatic.com/team-logos/team-cap-on-dark/121.svg"
        case .pirates: return "https://www.mlbstatic.com/team-logos/team-cap-on-dark/134.svg"
        case .mariners: return "https://www.mlbstatic.com/team-logos/team-cap-on-dark/136.svg"
        case .guardians: return "https://www.mlbstatic.com/team-logos/team-cap-on-light/114.svg"
        default: return "https://www.mlbstatic.com/team-logos/team-cap-on-dark/\(self.id).svg"
        }
    }
    
    var logoAspectRatio: CGFloat {
        switch self {
        case .phillies: return 0.73
        case .mets: return 0.79
        case .padres: return 0.8
        case .dodgers: return 0.76
        default: return 1
        }
    }
}

// MARK: Helpers
extension ActiveTeam {
    static var allTeams: [ActiveTeam] {
        ActiveTeam.allCases.filter( { $0 != .any} )
    }
    
    static func team(withIdentifier id: Int) -> ActiveTeam? {
        return ActiveTeam.allCases.first(where: {$0.id == id})
    }
    
    static var allAlphabetized: [ActiveTeam] {
        ActiveTeam.allTeams.sorted(by: { $0.name < $1.name })
    }
    
    static var allTeamsAlphabetized: [ActiveTeam] {
        ActiveTeam.allTeams.sorted(by: { $0.name < $1.name })
    }
    
    static func gameAbbreviation(homeTeam: ActiveTeam, awayTeam: ActiveTeam) -> String {
        return awayTeam.abbreviation + " @ " + homeTeam.abbreviation
    }
}
