//
//  File.swift
//  
//
//  Created by Daniel Weatrowski on 8/14/23.
//

import Foundation

public enum RecordSplitType: String {
    case home, away, lastTen, extraInning, oneRun, day, night, xWinLoss, xWinLossSeason
}

public struct WinLossRecord {
    
    public let wins: Int
    public let losses: Int
    public let winningPct: String
    
    public init(wins: Int, losses: Int, winningPct: String) {
        self.wins = wins
        self.losses = losses
        self.winningPct = winningPct
    }
    
    public var formattedRecord: String {
        return "\(wins)-\(losses)"
    }
    
    public func asStat() -> Stat<String> {
        return Stat<String>(value: formattedRecord)
    }
}

extension Optional where Wrapped == Stat<String> {
    public func unwrappedAndFormatted(_ formatType: StatFormatType = .dash) -> String {
        
        guard let unwrappedValue = self?.value else {
            return formatType.emptyText
        }
        
        return "\(unwrappedValue)"
    }
}
