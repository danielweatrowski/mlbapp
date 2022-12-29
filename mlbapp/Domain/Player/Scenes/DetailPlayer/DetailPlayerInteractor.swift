//
//  DetailPlayerInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/11/22.
//

import Foundation

protocol DetailPlayerBusinessLogic {
    func getPlayer(request: DetailPlayer.Request)
}

protocol DetailPlayerDataStore {
    var player: MLBPlayer? { get set }
    var personID: Int { get set }
}

struct DetailPlayerInteractor: DetailPlayerBusinessLogic, DetailPlayerDataStore {
    
    var player: MLBPlayer?
    var personID: Int
    
    var presenter: DetailPlayerPresentationLogic
    
    func getPlayer(request: DetailPlayer.Request) {
//        Task {
//            do {
//                let playerDict = try await SwiftMLB.person(withIdentifier: personID)
//                let player = MLBPlayer(personID: personID, responseDict: playerDict)
//                
//                
//                let response = DetailPlayer.Response(player: player)
//                presenter.presentPlayer(response: response)
//                
//            } catch {
//                print(error)
//            }
//        }
    }
}
