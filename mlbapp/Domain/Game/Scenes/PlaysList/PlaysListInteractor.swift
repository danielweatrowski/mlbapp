//
//  SummaryGameInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import Foundation
import Models
import Common
import OSLog

protocol PlaysListBusinessLogic {
    func loadAllPlays() async
    func filterPlays(by filterType: PlaysList.FilterType)
    func filterPlays(by teamSelectionType: PlaysList.TeamSelectionType)
}

protocol PlaysListDataStore  {
    var gameID: Int { get set }
    var plays: [Play]? { get }
    var eventTypeHash: [String: Play.EventType]? { get }
    var inningsPlayed: Int { get }
}

class PlaysListInteractor: ObservableObject, PlaysListBusinessLogic & PlaysListDataStore {
    
    let presenter: PlaysListPresentationLogic?
    let gameWorker = GameWorker(store: MLBAPIRepository())
    var gameID: Int
    
    var plays: [Play]?
    var eventTypeHash: [String: Play.EventType]?
    
    var inningsPlayed: Int {
        return plays?.last?.about.inning ?? 0
    }
    
    internal init(presenter: PlaysListPresentationLogic? = nil, gameID: Int) {
        self.presenter = presenter
        self.gameID = gameID
    }
    
    func loadAllPlays() async {
        do {
            let data = try await loadAll()
            self.plays = data.plays
            self.eventTypeHash = data.eventTypes
            
            let output = PlaysList.Output(plays: data.plays,
                                            totalInningsPlayed: data.plays.last?.about.inning ?? 0)
            presenter?.presentPlaysList(output: output)
        } catch {
            Logger.game.error("Did fail to load all plays: \(error, privacy: .public)")
            
            let sceneError = SceneError(errorDescription: error.localizedDescription)
            presenter?.presentSceneError(sceneError)
        }
    }
    
    func filterPlays(by filterType: PlaysList.FilterType) {
        guard let allPlays = plays, let eventTypeHash = eventTypeHash else {
            let sceneError = SceneError(errorDescription: "No data found.")
            presenter?.presentSceneError(sceneError)
            return
        }
        switch filterType {
        case .all:
            present(plays: allPlays, thru: inningsPlayed)
        case .hits:
            var hitPlays = allPlays.filter({
                guard let eventType = $0.result.eventType else { return false }
                let isHit = eventTypeHash[eventType]?.hit ?? false
                return isHit
            })
            present(plays: hitPlays, thru: inningsPlayed)
        case .homeruns:
            var homeruns = allPlays.filter({
                return $0.isHomerun
            })
            present(plays: homeruns, thru: inningsPlayed)
        case .scoring:
            var scoringPlays = allPlays.filter({
                return $0.isScoringPlay
            })
            present(plays: scoringPlays, thru: inningsPlayed)
        case .strikeOut:
            var strikeouts = allPlays.filter({
                return $0.isStrikeOut
            })
            present(plays: strikeouts, thru: inningsPlayed)
        }
    }
    
    func filterPlays(by teamSelectionType: PlaysList.TeamSelectionType) {
        guard let allPlays = plays else {
            let sceneError = SceneError(errorDescription: "No data found.")
            presenter?.presentSceneError(sceneError)
            return
        }
        switch teamSelectionType {
        case .all:
            present(plays: allPlays, thru: inningsPlayed)
        case .home:
            var homePlays = allPlays.filter({
                return $0.isHomeTeam
            })
            present(plays: homePlays, thru: inningsPlayed)
        case .away:
            var awayPlays = allPlays.filter({
                return $0.isAwayTeam
            })
            present(plays: awayPlays, thru: inningsPlayed)
        }
    }

    
    private func loadAll() async throws -> (plays: [Play], eventTypes: [String: Play.EventType]) {
        async let plays = loadPlays()
        async let eventTypes = loadEvents()
        
        return try await (plays, eventTypes)
    }
    
    private func loadPlays() async throws -> [Play] {
        let playDetail = try await gameWorker.fetchAllPlays(forGameID: gameID)
        return playDetail.allPlays
    }
    
    private func loadEvents() async throws -> [String: Play.EventType] {
        return try await gameWorker.fetchPlayEventTypes()
    }
    
    private func present(plays: [Play], thru innings: Int) {
        let output = PlaysList.Output(plays: plays, totalInningsPlayed: innings)
        presenter?.presentPlaysList(output: output)
    }
}
