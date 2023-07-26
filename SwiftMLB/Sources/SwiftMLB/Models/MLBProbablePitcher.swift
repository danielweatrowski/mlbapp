//
//  MLBProbablePitcher.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation

public struct MLBProbablePitcher: Codable {
    public struct Player: Codable {
        public let id: Int
        public let fullName: String
        public let link: String
    }
    
    public let home: Player?
    public let away: Player?
}
