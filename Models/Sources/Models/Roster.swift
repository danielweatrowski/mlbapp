//
//  Roster.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/2/23.
//

import Foundation

public struct Roster {
    
    public struct Player {
        
        public init(personID: Int, weight: Int? = nil, height: String? = nil, age: Int? = nil, throwingHandCode: String, throwingHand: String, battingSideCode: String, battingSide: String, fullName: String, position: Position? = nil, statusCode: String, statusDescription: String, jerseyNumber: String) {
            self.personID = personID
            self.weight = weight
            self.height = height
            self.age = age
            self.throwingHandCode = throwingHandCode
            self.throwingHand = throwingHand
            self.battingSideCode = battingSideCode
            self.battingSide = battingSide
            self.fullName = fullName
            self.position = position
            self.statusCode = statusCode
            self.statusDescription = statusDescription
            self.jerseyNumber = jerseyNumber
        }
        
        public let personID: Int
        public let weight: Int?
        public let height: String?
        public let age: Int?
        public let throwingHandCode: String
        public let throwingHand: String
        public let battingSideCode: String
        public let battingSide: String
        public let fullName: String
        public let position: Position?
        public let statusCode: String
        public let statusDescription: String
        public let jerseyNumber: String
    }
    
    public let players: [Player]
    
    public init(players: [Roster.Player]) {
        self.players = players
    }
}
