//
//  Stat.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/16/23.
//

import Foundation

public enum StatFormatType {
    case int, decimal, pitchingRecord, dash, none
    
    public var emptyText: String {
        switch self {
        case .int:
            return "0"
        case .decimal:
            return ".000"
        case .pitchingRecord:
            return "0-0"
        case .dash:
            return "-"
        case .none:
            return ""
        }
    }
}

public struct Stat<T> {
    
    let value: T?
    
    public func formatted(_ formatType: StatFormatType = .dash) -> String {
        
        guard let unwrappedValue = value else {
            return formatType.emptyText
        }
        
        return "\(unwrappedValue)"
    }
    
    public init(value: T? = nil) {
        self.value = value
    }
}

public extension Optional where Wrapped == String {
    func asStat() -> Stat<String> {
        return Stat<String>(value: self)
    }
}

public extension Optional where Wrapped == Int {
    func asStat() -> Stat<Int> {
        return Stat<Int>(value: self)
    }
}

public extension Optional where Wrapped == Int {
    func formattedStat() -> String {
        if let stat = self {
            return "\(stat)"
        } else {
            return "-"
        }
    }
}
