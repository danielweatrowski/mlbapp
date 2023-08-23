//
//  StandingsListPresenterTests.swift
//  mlbappTests
//
//  Created by Daniel Weatrowski on 7/23/23.
//

import XCTest
@testable import Standings
@testable import Models
@testable import Common

final class StandingsListPresenterTests: XCTestCase {
    
    var sut: StandingsListPresenter<StandingsListRenderLogicSpy>?

    override func setUpWithError() throws {
        sut = nil
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    class StandingsListRenderLogicSpy: StandingsListRenderingLogic {
        
        var renderStandingsDetailCalled = false
        var renderStandingsListCalled = false
        var renderWildcardStandingsListCalled = false
        var renderSceneErrorCalled = false
        
        func renderStandingsList(viewModel: StandingsList.LoadStandings.ViewModel) {
            renderStandingsListCalled = true
        }
        
        func renderWildcardStandingsList(viewModel: StandingsList.FormatWildcard.ViewModel) {
            renderWildcardStandingsListCalled = true
        }
        
        func renderSceneError(_ sceneError: SceneError) {
            renderSceneErrorCalled = true
        }
        
        func renderStandingsDetail(teamStanding: Models.Standings.TeamRecord) {
            renderStandingsDetailCalled = true
        }
    }
    
    func testPresentStandingsListShouldFormatStandingsForViewModel() {
        // given
        let viewSpy = StandingsListRenderLogicSpy()
        sut = StandingsListPresenter(viewModel: viewSpy)
        
        // when
        let output = StandingsList.LoadStandings.Output(nationalLeagueStandings: Seeds.LeagueRecords.nl,
                                                        americanLeagueStandings: Seeds.LeagueRecords.al)
        sut?.presentStandingsList(output: output)
        
        // then
        XCTAssert(viewSpy.renderStandingsListCalled)
    }
    
    func testPresentStandingsDetail() {
        // given
        let viewSpy = StandingsListRenderLogicSpy()
        sut = StandingsListPresenter(viewModel: viewSpy)
        
        // when
        let output = StandingsList.LoadDetail.Output(standing: Seeds.TeamRecords.lad)
        sut?.presentTeamStandingDetail(ouput: output)
        
        // then
        XCTAssert(viewSpy.renderStandingsDetailCalled)
    }

}
