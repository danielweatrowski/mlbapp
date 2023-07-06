//
//  Division.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

struct Division: Codable {
    let id: Int
    let name: String
}


enum ActiveDivision: Int {
    case nlCentral = 205
    case nlWest = 203
    case nlEast = 204
    case alWest = 200
    case alEast = 201
    case alCentral = 202
    
    var name: String {
        switch self {
        case .nlCentral:
            return "National League Central"
        case .nlWest:
            return "National League West"
        case .nlEast:
            return "National League East"
        case .alWest:
            return "American League West"
        case .alEast:
            return "American League East"
        case .alCentral:
            return "American League Central"
        }
    }
    
    var nameShort: String {
        switch self {
        case .nlCentral:
            return "NL Central"
        case .nlWest:
            return "NL West"
        case .nlEast:
            return "NL East"
        case .alWest:
            return "AL West"
        case .alEast:
            return "AL East"
        case .alCentral:
            return "AL Central"
        }
    }
}
