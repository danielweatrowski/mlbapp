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
    
    func data(options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        let obj = try builder.build(with: data)
        obj.printPretty()
        return try JSONSerialization.data(withJSONObject: obj, options: opt)
    }
    
    func data(withJSONObject obj: Any, options opt: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: obj, options: opt)
    }
    
    func jsonObject() throws -> [String: Any] {
        return try builder.build(with: data)
    }
}
