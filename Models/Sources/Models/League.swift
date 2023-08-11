//
//  League.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/3/23.
//

import Foundation

public struct League: Codable {
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

public enum ActiveLeague: Int, CaseIterable {
    case national = 104
    case american = 103
    
    public var name: String {
        switch self {
        case .national:
            return "National League"
        case .american:
            return "American League"
        }
    }
    
    public var nameShort: String {
        switch self {
        case .national:
            return "National"
        case .american:
            return "American"
        }
    }
    
    public var divisions: [ActiveDivision] {
        switch self {
        case .national:
            return [.nlEast, .nlCentral, .nlWest]
        case .american:
            return [.alEast, .alCentral, .alWest]
        }
    }
}
