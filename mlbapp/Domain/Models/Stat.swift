//
//  Stat.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

protocol StatProtocol {
    
}

enum StatFormatType {
    case int, decimal, pitchingRecord, dash
    
    var emptyText: String {
        switch self {
        case .int:
            return "0"
        case .decimal:
            return ".000"
        case .pitchingRecord:
            return "0-0"
        case .dash:
            return "-"
        }
    }
}

struct Stat<T>: StatProtocol {
    let value: T?
    
    func formatted(_ formatType: StatFormatType = .dash) -> String {
        
        guard let unwrappedValue = value else {
            return formatType.emptyText
        }
        
        return "\(unwrappedValue)"
    }
}

extension Optional where Wrapped == Int {
    func formattedStat() -> String {
        if let stat = self {
            return "\(stat)"
        } else {
            return "-"
        }
    }
}
