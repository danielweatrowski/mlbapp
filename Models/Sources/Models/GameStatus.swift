//
//  GameStatus.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation

public enum GameStatus: String, Codable {
    case live = "Live"
    case final = "Final"
    case preview = "Preview"
    case other = "Other"
    
    public var friendlyName: String {
        switch self {
        case .live: return "Live"
        case .preview: return "Preview"
        case .final: return "Final"
        case .other: return "Other"
        }
    }
}
