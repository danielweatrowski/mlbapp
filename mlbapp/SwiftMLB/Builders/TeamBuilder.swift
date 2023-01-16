//
//  TeamBuilder.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import Foundation

struct TeamBuilder: JSONBuilder {
    func build(with data: Data) throws -> [String : Any] {
        guard let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw SwiftMLBError.invalidData
        }
        
        return dict
    }
}
