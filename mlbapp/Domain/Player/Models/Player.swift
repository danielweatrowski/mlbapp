//
//  Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation

protocol Player {
    var id: Int { get set }
    
    var firstName: String { get set }
    
    var lastName: String { get set }
    
    var primaryNumber: String { get set }
}

struct MLBPlayer: Player {
    var id: Int
    
    var firstName: String
    
    var lastName: String
    
    var primaryNumber: String
    
    var fullName: String {
        firstName + " " + lastName
    }
}

extension MLBPlayer {
    var test: Self {
        .init(id: 571448, firstName: "Nolan", lastName: "Arenado", primaryNumber: "28")
    }
}
