//
//  Count.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/10/23.
//

import Foundation

public struct Count: Codable {
    
    public let balls: Int
    public let strikes: Int
    public let outs: Int
    
    public init(balls: Int, strikes: Int, outs: Int) {
        self.balls = balls
        self.strikes = strikes
        self.outs = outs
    }
    
    public func ballsStrikesFormatted() -> String {
       return "\(balls)-\(strikes)"
    }
}
