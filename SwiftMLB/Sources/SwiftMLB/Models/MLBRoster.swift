//
//  MLBRoster.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

public struct MLBRoster: Decodable {
    public struct Player: Decodable {
        
        public struct Status: Decodable {
            public let code: String
            public let description: String
        }
        
        public let status: Status?
        public let position: MLBPosition?
        public let person: MLBPlayer?
        public let jerseyNumber: String?
        
    }
    
    public let roster: [Player]
    public let teamId: Int
    public let rosterType: String
}
