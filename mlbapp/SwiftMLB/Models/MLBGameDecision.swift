//
//  MLBGameDecision.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation

struct MLBGameDecision: Codable {
    
    struct Player: Codable {
        let id: Int
        let fullName: String
        let link: String
    }
    
    let winner: Player?
    let loser: Player?
    let save: Player?
}


