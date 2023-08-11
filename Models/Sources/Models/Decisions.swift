//
//  Decisions.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import Foundation

public struct Decisions: Codable {
    
    public let winner: Person
    public let loser: Person
    public let save: Person?
    
    public init(winner: Person, loser: Person, save: Person? = nil) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}
