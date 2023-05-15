//
//  Play.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation

protocol PlayProtocol {
    associatedtype Result = PlayResultProtocol
    associatedtype Detail = PlayDetailProtocol
    var result: Result { get }
    var about: Detail { get }
}

protocol PlayResultProtocol {
    var type: String { get }
    var event: String { get }
    var eventType: String { get }
    var description: String { get }
    var rbi: Int { get }
    var awayScore: Int { get }
    var homeScore: Int { get }
    var isOut: Bool { get }
}

protocol PlayDetailProtocol {
    var atBatIndex: Int { get }
    var halfInning: String { get }
    var inning: Int { get }
    var hasOut: Bool { get }
    var endTime: Date { get }
}

struct Play: PlayProtocol {
    
    var result: Result
    
    var about: Detail
    
    
    struct Result: PlayResultProtocol {
        var type: String
        
        var event: String
        
        var eventType: String
        
        var description: String
        
        var rbi: Int
        
        var awayScore: Int
        
        var homeScore: Int
        
        var isOut: Bool
    }
    
    struct Detail: PlayDetailProtocol {
        
        var atBatIndex: Int
        
        var halfInning: String
        
        var inning: Int
        
        var hasOut: Bool
        
        var endTime: Date
    }
    
}

