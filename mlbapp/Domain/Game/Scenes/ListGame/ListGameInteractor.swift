//
//  ListGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/5/22.
//

import Foundation
import Combine

protocol ListGameBusinessLogic {}

protocol ListGameDataStore {
    var lookupResults: [Game] { get set }
}

class ListGameInteractor: ListGameBusinessLogic, ListGameDataStore {
    var lookupResults: [Game]
    
    init(lookupResults: [Game]) {
        self.lookupResults = lookupResults
    }
}
