//
//  MLBPlayer.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/5/23.
//

import Foundation

protocol MLBPlayerProtocol {
    var id: Int { get set }

    var firstName: String { get set }

    var lastName: String { get set }
    
    var fullName: String { get set }

    var primaryNumber: String? { get set }

    var nickname: String? { get set }
    
    var lastInitName: String { get set }
    
    var boxscoreName: String { get set }
    
    var height: String { get set }
    
    var weight: Int { get set }
    
    var currentAge: Int { get set }
    
    var birthDate: String { get set }
    
    var active: Bool { get set }
    
    var mlbDebutDate: String { get set }
    
    var birthCity: String { get set }
    
    var birthStateProvince: String? { get set }
    
    var birthCountry: String { get set }
}

struct MLBPlayer: MLBPlayerProtocol, Codable {
    var birthCity: String
    
    var birthStateProvince: String?
    
    var birthCountry: String
    
    var id: Int
    
    var firstName: String
    
    var lastName: String
    
    var fullName: String
    
    var primaryNumber: String?
    
    var nickname: String?
    
    var lastInitName: String
    
    var boxscoreName: String
    
    var height: String
    
    var weight: Int
    
    var currentAge: Int
    
    var birthDate: String
    
    var active: Bool
    
    var mlbDebutDate: String
    
    var primaryPosition: MLBPosition
}
