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
        let fullName: String
        let position: Position?
        let statusCode: String
        let statusDescription: String
        let jerseyNumber: String
    }
    
    let players: [Player]
}
