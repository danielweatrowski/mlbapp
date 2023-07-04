//
//  MLBPlayer.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/5/23.
//

import Foundation

struct MLBPlayer: Codable {
    struct Orientation: Codable {
        let code: String
        let description: String
    }
    
    var birthCity: String?
    
    var birthStateProvince: String?
    
    var birthCountry: String?
    
    var id: Int
    
    var firstName: String
    
    var lastName: String
    
    var fullName: String
    
    var primaryNumber: String
    
    var nickname: String?
    
    var lastInitName: String?
    
    var boxscoreName: String?
    
    var height: String?
    
    var weight: Int?
    
    var currentAge: Int?
    
    var birthDate: String?
    
    var active: Bool
    
    var mlbDebutDate: String?
    
    var primaryPosition: MLBPosition
    
    var batSide: Orientation?
    
    var pitchHand: Orientation?
}
