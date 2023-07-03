//
//  RosterDetailInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import Foundation

protocol RosterDetailBusinessLogic {
    func loadRosters()
}
protocol RosterDetailDataStore  {
    var homeTeam: Team? { get set }
    var awayTeam: Team? { get set }
    var gameDate: Date? { get set }
}

struct RosterDetailInteractor: RosterDetailBusinessLogic, RosterDetailDataStore {
    var homeTeam: Team?
    var awayTeam: Team?
    var gameDate: Date?
    
    let presenter: RosterDetailPresentationLogic?
    
    private let gameWorker = GameWorker(store: MLBAPIRepository())

    
    func loadRosters() {
        guard let homeTeamID = homeTeam?.id, let awayTeamID = awayTeam?.id, let gameDate = gameDate else {
            let sceneError = SceneError(errorDescription: "Did find nil team IDs or game date")
            presenter?.presentSceneError(sceneError)
            return
        }
        Task {
            do {
                let rosters = try await loadRostersAsync(homeID: homeTeamID, awayID: awayTeamID, gameDate: gameDate)
                let output = RosterDetail.Output(homeRoster: rosters.home, awayRoster: rosters.away)
                presenter?.presentRoster(output: output)
            } catch {
                let sceneError = SceneError(errorDescription: error.localizedDescription)
                presenter?.presentSceneError(sceneError)
            }
        }
    }
    
    private func loadRostersAsync(homeID: Int, awayID: Int, gameDate: Date) async throws -> (home: Roster, away: Roster) {
        async let homeRoster = loadHomeRoster(homeID, gameDate)
        async let awayRoster = loadAwayRoster(awayID, gameDate)
        
        return try await (homeRoster, awayRoster)
    }
    
    private func loadHomeRoster(_ homeID: Int, _ date: Date) async throws -> Roster {
        return try await gameWorker.fetchRoster(teamID: homeID, date: date)
    }
    
    private func loadAwayRoster(_ awayID: Int, _ date: Date) async throws -> Roster {
        return try await gameWorker.fetchRoster(teamID: awayID, date: date)
    }
}
