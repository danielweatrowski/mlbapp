//
//  GameStatus.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import Foundation

enum GameStatus: String {
    case live = "Live"
    case final = "Final"
    case preview = "Preview"
    case other = "Other"
    
    var friendlyName: String {
        switch self {
        case .live: return "Live"
        case .preview: return "Preview"
        case .final: return "Final"
        case .other: return "Other"
        }
    }
}
