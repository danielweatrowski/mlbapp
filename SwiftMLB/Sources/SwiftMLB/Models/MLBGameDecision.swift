//
//  MLBGameDecision.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation

public struct MLBGameDecision: Codable {
    
    public struct Player: Codable {
        public let id: Int
        public let fullName: String
        public let link: String
    }
    
    public let winner: Player?
    public let loser: Player?
    public let save: Player?
}


