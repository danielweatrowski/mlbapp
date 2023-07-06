//
//  League.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct League: Codable {
    let id: Int
    let name: String
}

enum ActiveLeague: Int, CaseIterable {
    case national = 104
    case american = 103
    
    var name: String {
        switch self {
        case .national:
            return "National League"
        case .american:
            return "American League"
        }
    }
    
    var nameShort: String {
        switch self {
        case .national:
            return "National"
        case .american:
            return "American"
        }
    }
    
    var divisions: [ActiveDivision] {
        switch self {
        case .national:
            return [.nlEast, .nlCentral, .nlWest]
        case .american:
            return [.alEast, .alCentral, .alWest]
        }
    }
}
