//
//  SwiftMLB+Player.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/25/22.
//

import Foundation

extension SwiftMLB {
    static func player(parameters: SwiftMLBRequest.PersonParameters) async throws -> [String: Any] {
        let request: SwiftMLBRequest = .player(parameters)
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
        
        guard let nickName = person["nickName"] as? String else {
            throw SwiftMLBError.keyNotFound(key: "nickName")
        }
        
        guard let primaryNumber = person["primaryNumber"] as? String else {
            throw SwiftMLBError.keyNotFound(key: "primaryNumber")
        }
        
        return [
            "firstName": firstName,
            "lastName": lastName,
            "nickName": nickName,
            "primaryNumber": primaryNumber
        ]
    }

}

