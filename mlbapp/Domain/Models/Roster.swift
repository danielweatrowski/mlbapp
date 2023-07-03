//
//  Roster.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/2/23.
//

import Foundation

struct Roster {
    struct Player {
        let personID: Int
        let weight: Int?
        let height: String?
        let age: Int?
        let throwingHandCode: String
        let throwingHand: String
        let battingSideCode: String
        let battingSide: String
        let fullName: String
        let position: Position?
        let statusCode: String
        let statusDescription: String
        let jerseyNumber: String
    }
    
    let players: [Player]
}
