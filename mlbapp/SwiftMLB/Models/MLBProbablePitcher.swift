//
//  MLBProbablePitcher.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation

struct MLBProbablePitcher: Codable {
    struct Player: Codable {
        let id: Int
        let fullName: String
        let link: String
    }
    
    let home: Player?
    let away: Player?
}
