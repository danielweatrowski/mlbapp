//
//  RosterDetailInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

protocol RosterDetailBusinessLogic {
    func loadRoster()
}
protocol RosterDetailDataStore  {
    var gameID: Int { get set }
}

struct RosterDetailInteractor: RosterDetailBusinessLogic, RosterDetailDataStore {
    
    var gameID: Int
    let presenter: RosterDetailPresentationLogic?
    
    func loadRoster() {
        
    }
    
}
