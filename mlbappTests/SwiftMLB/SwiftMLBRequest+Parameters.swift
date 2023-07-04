//
//  SwiftMLBRequest+Parameters.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/25/22.
//

import XCTest
@testable import mlbapp

class SwiftMLBRequest_Parameters: XCTestCase {

    func testPlayerAllStats() {
        
        // given
        let parameters = SwiftMLBRequest.PersonParameters(hydrate: .init(group: [.fielding, .hitting, .pitching],
                                                                         type: [.season, .career, .yearByYear]))
        
        // when
        let queryItems = parameters.toQueryItems()
        
        // then
        let expected = URLQueryItem(name: "hydrate", value: "stats(group=[fielding,hitting,pitching],type=[season,career,yearByYear]),currentTeam")
        XCTAssertEqual(expected.value, queryItems.first?.value)
    }
    
    func testPlayerNoStats() {
        // given
        let parameters = SwiftMLBRequest.PersonParameters(hydrate: nil)
        
        // when
        let queryItems = parameters.toQueryItems()
        
        // then
        let expected = [URLQueryItem(name: "hydrate", value: nil)]
        XCTAssertEqual(expected.first, queryItems.first)
    }
    
    func testPlayerAllHittingStats() {
        // given
        let parameters = SwiftMLBRequest.PersonParameters(hydrate: .init(group: [.hitting],
                                                                         type: [.season, .career, .yearByYear]))
        
        // when
        let queryItems = parameters.toQueryItems()
        
        // then
        let expected = URLQueryItem(name: "hydrate", value: "stats(group=[hitting],type=[season,career,yearByYear]),currentTeam")
        XCTAssertEqual(expected.value, queryItems.first?.value)
    }
    
    func testPlayerSeasonStats() {
        // given
        let parameters = SwiftMLBRequest.PersonParameters(hydrate: .init(group: [.fielding, .hitting, .pitching],
                                                                         type: [.season]))
        
        // when
        let queryItems = parameters.toQueryItems()
        
        // then
        let expected = URLQueryItem(name: "hydrate", value: "stats(group=[fielding,hitting,pitching],type=[season]),currentTeam")
        XCTAssertEqual(expected.value, queryItems.first?.value)
    }
}
