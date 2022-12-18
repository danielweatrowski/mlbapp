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
    
    var nickname: String? { get set }

}

struct MLBPlayer: Player {
    
    var id: Int
    
    var firstName: String
    
    var lastName: String
    
    var primaryNumber: String
    
    var nickname: String?
    
    var fullName: String {
        firstName + " " + lastName
    }
    
    /// Init with SwiftMLB dictionary response for endpoint `.person(_)`
    init(personID: Int, responseDict: [String: Any]) {
        self.id = personID
        self.firstName = responseDict["firstName"] as? String ?? ""
        self.lastName = responseDict["lastName"] as? String ?? ""
        self.nickname = responseDict["nickName"] as? String
        self.primaryNumber = responseDict["primaryNumber"] as? String ?? "?"
    }
    
    init(id: Int, firstName: String, lastName: String, primaryNumber: String, nickname: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.primaryNumber = primaryNumber
        self.nickname = nickname
    }
}

extension MLBPlayer {
    static let test: Self = .init(id: 571448, firstName: "Nolan", lastName: "Arenado", primaryNumber: "28", nickname: "Nado")
}
