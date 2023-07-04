//
//  Error.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/23/22.
//

import Foundation

enum SwiftMLBError: Error {
    case invalidURL(urlString: String)
    
    case keyNotFound(key: String)
    
    case invalidData
    
    case notFound
}

extension SwiftMLBError: CustomStringConvertible {
    
    // TODO: Add endpoint details to description
    var description: String {
        switch self {
            
        case .invalidURL(let urlString):
            return "The following is not a valid URL: \(urlString)"
            
        case .keyNotFound(key: let key):
            return "SwiftMLB was unable to locate the following key: \(key)"
            
        case .invalidData:
            return "The data returned to SwiftMLB was invalid"
            
        case .notFound:
            return "The resource is currently unavailable or does not exist"
        }
    }
}
