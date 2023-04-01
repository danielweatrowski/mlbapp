//
//  BoxscoreInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/31/23.
//

import Foundation

protocol BoxscoreDetailBusinessLogic {
    func loadBoxscore()
}

protocol BoxscoreDetailDataStore  {
    var gameID: Int { get set }
}

struct BoxscoreDetailInteractor: BoxscoreDetailBusinessLogic & BoxscoreDetailDataStore {
    
    var gameID: Int
    
    func loadBoxscore() {
        // TODO: Implement
    }
}
