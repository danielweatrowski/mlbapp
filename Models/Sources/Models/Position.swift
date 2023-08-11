//
//  Position.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/13/23.
//

import Foundation

public struct Position: Codable {
    
    public let code: String?
    public let type: String?
    public let name: String?
    public let abbreviation: String?
    
    public init(code: String? = nil, type: String? = nil, name: String? = nil, abbreviation: String? = nil) {
        self.code = code
        self.type = type
        self.name = name
        self.abbreviation = abbreviation
    }
}
