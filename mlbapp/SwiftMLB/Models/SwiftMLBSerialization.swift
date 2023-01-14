//
//  SwiftMLBSerialization.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/13/23.
//

import Foundation

struct SwiftMLBSerialization {
    
    private let builder: JSONBuilder
    private let data: Data
    
    init(data: Data, builder: JSONBuilder) {
        self.builder = builder
        self.data = data
    }
    
    func data(options: JSONSerialization.WritingOptions = []) throws -> Data {
        let object = try builder.build(with: data)
        object.printPretty()
        return try JSONSerialization.data(withJSONObject: object, options: options)
    }
    
    func jsonObject() throws -> [String: Any] {
        return try builder.build(with: data)
    }
}
