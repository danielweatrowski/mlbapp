//
//  File.swift
//  
//
//  Created by Daniel Weatrowski on 10/16/22.
//

import Foundation

// MARK: - TeamResponse
public struct TeamResponse: Codable {
    public let copyright: String
    public let teams: [Team]
}

// MARK: - Team
public struct Team: Codable {
    public let springLeague: Division
    public let allStarStatus: String
    public let id: Int
    public let name, link: String
    public let season: Int
    public let venue: Division
    public let springVenue: SpringVenue
    public let teamCode, fileCode, abbreviation, teamName: String
    public let locationName, firstYearOfPlay: String
    public let league, division, sport: Division
    public let shortName, franchiseName, clubName: String
    public let active: Bool
}

// MARK: - Division
public struct Division: Codable {
    public let id: Int
    public let name, link: String
    public let abbreviation: String?
}

// MARK: - SpringVenue
public struct SpringVenue: Codable {
    public let id: Int
    public let link: String
}


