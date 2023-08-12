//
//  ActiveTeamColor.swift
//  
//
//  Created by Daniel Weatrowski on 8/12/23.
//

import Foundation
import SwiftUI

public enum ActiveTeamColor: Int {
    case dodgers = 119
    case rangers = 140
    case mets = 121
    case pirates = 134
    case mariners = 136
    case padres = 135
    case cardinals = 138
    case giants = 137
    case rays = 139
    case blueJays = 141
    case twins = 142
    case phillies = 143
    case braves = 144
    case whiteSox = 145
    case marlins = 146
    case yankees = 147
    case brewers = 158
    case diamondbacks = 109
    case rockies = 115
    case angels = 108
    case guardians = 114
    case cubs = 112
    case reds = 113
    case nationals = 120
    case tigers = 116
    case royals = 118
    case astros = 117
    case orioles = 110
    case athletics = 133
    case redSox = 111
    
    public var color: Color {
        switch self {
        case .dodgers:
            return .blue
        case .rangers:
            return .red
        case .mets:
            return .blue
        case .pirates:
            return .yellow
        case .mariners:
            return .navy
        case .padres:
            return .yellow
        case .cardinals:
            return .red
        case .giants:
            return .orange
        case .rays:
            return .navy
        case .blueJays:
            return .blue
        case .twins:
            return .navy
        case .phillies:
            return .red
        case .braves:
            return .navy
        case .whiteSox:
            return .primary
        case .marlins:
            return .teal
        case .yankees:
            return .primary
        case .brewers:
            return .navy
        case .diamondbacks:
            return .red
        case .rockies:
            return .purple
        case .angels:
            return .red
        case .guardians:
            return .red
        case .cubs:
            return .blue
        case .reds:
            return .red
        case .nationals:
            return .red
        case .tigers:
            return .orange
        case .royals:
            return .blue
        case .astros:
            return .orange
        case .orioles:
            return .orange
        case .athletics:
            return .green
        case .redSox:
            return .red
        @unknown default:
            return .primary
        }
    }
}

extension Color {
    static var navy: Self {
        return Color(red: 0, green: 0.329, blue: 0.575)
    }
}

extension View {
    public func teamForegroundColor(teamID: Int) -> some View {
        
        self
            .foregroundColor(ActiveTeamColor(rawValue: teamID)?.color ?? .primary)
    }
}
