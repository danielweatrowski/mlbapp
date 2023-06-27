//
//  Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/5/23.
//

import Foundation


//protocol Player {
//    var id: Int { get set }
//
//    var firstName: String { get set }
//
//    var lastName: String { get set }
//
//    var primaryNumber: String { get set }
//
//    var nickname: String? { get set }
//
//}

struct Player: Hashable, Codable {
    
    var id: Int
    
    var firstName: String
    
    var lastName: String
    
    var fullName: String
    
    var primaryNumber: String?
    
    var nickname: String?
    
    var birthCity: String
    
    var birthStateProvince: String?
    
    var birthCountry: String
    
    var lastInitName: String
    
    var boxscoreName: String
    
    var height: String
    
    var weight: Int
    
    var currentAge: Int
    
    var birthDate: String
    
    var isActive: Bool
    
    var mlbDebutDate: String
    
    var primaryPositionCode: String
}
