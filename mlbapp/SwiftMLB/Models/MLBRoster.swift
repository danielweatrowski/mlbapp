//
//  MLBRoster.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

struct MLBRoster: Decodable {
    struct Player: Decodable {
        
        struct Status: Decodable {
            let code: String
            let description: String
        }
        
        let status: Status?
        let position: MLBPosition?
        let person: MLBPerson?
        let jerseyNumber: String?
        
    }
    
    let roster: [Player]
    let teamId: Int
    let rosterType: String
}
