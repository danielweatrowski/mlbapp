//
//  SwiftMLB+Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation

extension SwiftMLB {
    
    static func person(withIdentifier personID: Int) async throws -> [String: Any] {
        let request: MLBRequest = .person(personID)
        let data = try await networkService.load(request)
        
        // parse the data
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        guard let people = dict["people"] as? [[String: Any]] else {
            throw SwiftMLBError.keyNotFound(key: "people")
        }
        
        guard let person = people.first else {
            throw SwiftMLBError.notFound
        }
        
        guard let firstName = person["firstName"] as? String else {
            throw SwiftMLBError.keyNotFound(key: "firstName")
        }
        
        guard let lastName = person["lastName"] as? String else {
            throw SwiftMLBError.keyNotFound(key: "lastName")
        }
        
        guard let primaryNumber = person["primaryNumber"] as? String else {
            throw SwiftMLBError.keyNotFound(key: "primaryNumber")
        }
        
        return [
            "firstName": firstName,
            "lastName": lastName,
            "primaryNumber": primaryNumber
        ]
    }
    
    static func headshot(forPersonIdentifier personID: Int) async throws -> Data {
        let request: MLBRequest = .headshot(personID)
        
        let data = try await networkService.load(request)
        
        return data
    }
}
