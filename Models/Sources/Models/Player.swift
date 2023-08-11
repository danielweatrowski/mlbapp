//
//  Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/5/23.
//

import Foundation

public struct Player: Hashable, Codable {
    
    public var id: Int
    
    public var firstName: String
    
    public var lastName: String
    
    public var fullName: String
    
    public var primaryNumber: String?
    
    public var nickname: String?
    
    public var birthCity: String?
    
    public var birthStateProvince: String?
    
    public var birthCountry: String?
    
    public var lastInitName: String?
    
    public var boxscoreName: String?
    
    public var height: String?
    
    public var weight: Int?
    
    public var currentAge: Int?
    
    public var birthDate: String?
    
    public var isActive: Bool
    
    public var mlbDebutDate: String?
    
    public var primaryPositionCode: String?
    
    public init(id: Int, firstName: String, lastName: String, fullName: String, primaryNumber: String? = nil, nickname: String? = nil, birthCity: String? = nil, birthStateProvince: String? = nil, birthCountry: String? = nil, lastInitName: String? = nil, boxscoreName: String? = nil, height: String? = nil, weight: Int? = nil, currentAge: Int? = nil, birthDate: String? = nil, isActive: Bool, mlbDebutDate: String? = nil, primaryPositionCode: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.primaryNumber = primaryNumber
        self.nickname = nickname
        self.birthCity = birthCity
        self.birthStateProvince = birthStateProvince
        self.birthCountry = birthCountry
        self.lastInitName = lastInitName
        self.boxscoreName = boxscoreName
        self.height = height
        self.weight = weight
        self.currentAge = currentAge
        self.birthDate = birthDate
        self.isActive = isActive
        self.mlbDebutDate = mlbDebutDate
        self.primaryPositionCode = primaryPositionCode
    }
}

public struct Person: Codable {
    
    public let id: Int
    public let fullName: String
    
    public init(id: Int, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
    
    public func displayName() -> String {
        let formatter = PersonNameComponentsFormatter()
        let components = formatter.personNameComponents(from: fullName)
        return components?.familyName ?? fullName
    }
}
