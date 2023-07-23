//
//  StandingsListInteractorTests.swift
//  mlbappTests
//
//  Created by Daniel Weatrowski on 7/22/23.
//

import XCTest
@testable import mlbapp

final class StandingsListInteractorTests: XCTestCase {
    
    var sut: StandingsListInteractor<StandingRepoSpy>?

    override func setUpWithError() throws {
        sut = nil
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    class StandingsListPresentationSpy: StandingsListPresentationLogic {
        
        var presentStandingsListCalled = false
        var presentWildcardStandingsListCalled = false
        var presentErrorCalled = false
        
        func presentStandingsList(output: mlbapp.StandingsList.LoadStandings.Output) {
            presentStandingsListCalled = true
        }
        
        func presentWildcardStandingsList(output: mlbapp.StandingsList.FormatWildcard.Output) {
            presentWildcardStandingsListCalled = true
        }
        
        func presentSceneError(_ sceneError: mlbapp.SceneError) {}
    }
    
    class StandingRepoSpy: StandingsStoreProtocol {
        var fetchStandingsCalled = false
        
        func fetchStandings(for date: Date) async throws -> mlbapp.Standings {
            fetchStandingsCalled = true
            let al = Standings.LeagueRecord.createAmericanLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [])
            let nl = Standings.LeagueRecord.createNationalLeague(eastTeamRecords: [], centralTeamRecords: [], westTeamRecords: [])
            
            return Standings(nationalLeagueRecords: nl, americanLeagueRecords: al)
        }
    }
    
    // MARK: - Load Standings
    func testLoadStandingsShouldAskWorkerForStandingsAndPresenterToFormat() async {
        
        // given
        let presenter = StandingsListPresentationSpy()
        let store = StandingRepoSpy()
        sut = StandingsListInteractor(presenter: presenter,
                                      standingsStore: store)
        // when
        let _ = await sut?.loadStandings()
        
        // then
        XCTAssert(store.fetchStandingsCalled, "loadStandings() should load standings from the StandingsWorker()")
        XCTAssert(presenter.presentStandingsListCalled, "loadStandings() should ask the presenter to format")
    }
    
}
