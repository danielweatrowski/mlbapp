//
//  MLBPlayer.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/5/23.
//

import Foundation

public struct MLBPlayer: Codable {
    public  struct Orientation: Codable {
        public let code: String
        public let description: String
    }
    
    public var birthCity: String?
    public var birthStateProvince: String?
    public var birthCountry: String?
    public var id: Int
    public var firstName: String
    public var lastName: String
    public var fullName: String
    public var primaryNumber: String
    public var nickname: String?
    public var lastInitName: String?
    public var boxscoreName: String?
    public var height: String?
    public var weight: Int?
    public var currentAge: Int?
    public var birthDate: String?
    public var active: Bool
    public var mlbDebutDate: String?
    public var primaryPosition: MLBPosition
    public var batSide: Orientation?
    public var pitchHand: Orientation?
}
