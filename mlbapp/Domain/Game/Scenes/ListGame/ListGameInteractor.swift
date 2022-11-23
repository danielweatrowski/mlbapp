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
    var lookupResults: [LookupGame.LookupGameResult] { get set }
}

class ListGameInteractor: ListGameBusinessLogic, ListGameDataStore {
    var lookupResults: [LookupGame.LookupGameResult]
    
    init(lookupResults: [LookupGame.LookupGameResult]) {
        self.lookupResults = lookupResults
    }
}
