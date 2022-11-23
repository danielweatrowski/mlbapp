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
    var lookupResults: [MLBGame] { get set }
}

class ListGameInteractor: ListGameBusinessLogic, ListGameDataStore {
    var lookupResults: [MLBGame]
    
    init(lookupResults: [MLBGame]) {
        self.lookupResults = lookupResults
    }
}
