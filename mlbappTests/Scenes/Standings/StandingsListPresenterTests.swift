////
////  StandingsListPresenterTests.swift
////  mlbappTests
////
////  Created by Daniel Weatrowski on 7/23/23.
////
//
//import XCTest
//@testable import mlbapp
//
//final class StandingsListPresenterTests: XCTestCase {
//    
//    var sut: StandingsListPresenter<StandingsListRenderLogicSpy>?
//
//    override func setUpWithError() throws {
//        sut = nil
//    }
//
//    override func tearDownWithError() throws {
//        sut = nil
//    }
//    
//    class StandingsListRenderLogicSpy: StandingsListRenderingLogic {
//        
//        var renderStandingsListCalled = false
//        var renderWildcardStandingsListCalled = false
//        var renderSceneErrorCalled = false
//        
//        func renderStandingsList(viewModel: mlbapp.StandingsList.LoadStandings.ViewModel) {
//            renderStandingsListCalled = true
//        }
//        
//        func renderWildcardStandingsList(viewModel: mlbapp.StandingsList.FormatWildcard.ViewModel) {
//            renderWildcardStandingsListCalled = true
//        }
//        
//        func renderSceneError(_ sceneError: mlbapp.SceneError) {
//            renderSceneErrorCalled = true
//        }
//    }
//    
//    func testPresentStandingsListShouldFormatStandingsForViewModel() {
//        // given
//        let viewSpy = StandingsListRenderLogicSpy()
//        sut = StandingsListPresenter(viewModel: viewSpy)
//        
//        // when
//        let output = StandingsList.LoadStandings.Output(nationalLeagueStandings: StandingsSeeds.LeagueRecords.nl,
//                                                        americanLeagueStandings: StandingsSeeds.LeagueRecords.al)
//        sut?.presentStandingsList(output: output)
//        
//        // then
//        XCTAssert(viewSpy.renderStandingsListCalled)
//    }
//
//}
