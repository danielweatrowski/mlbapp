//
//  BoxscoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import Foundation

struct BoxscoreViewModel {
    struct Batter {
        var id = UUID()
        var name: String
        var positionAbbreviation: String
        var atBats: String
        var runs: String
        var hits: String
        var runsBattedIn: String
        var baseOnBalls: String
        var strikeOuts: String
        var leftOnBase: String
        var average: String
        var substitution: Bool
        var label: String?
    }
    
    var homeTeamAbbreviation: String
    var homeNotes: [String]
    var homeBatters: [Batter]
    var homeBattingTotals: [String]
}

extension BoxscoreViewModel {
    struct Seed {
        static let harper_20190424 = BoxscoreViewModel.Batter(name: "Harper",
                                                            positionAbbreviation: "RF",
                                                            atBats: "4",
                                                            runs: "1",
                                                            hits: "1",
                                                            runsBattedIn: "1",
                                                            baseOnBalls: "1",
                                                            strikeOuts: "3",
                                                            leftOnBase: "4",
                                                            average: ".261",
                                                            substitution: false)
        static let mccutchen_20190424 = BoxscoreViewModel.Batter(name: "McCutchen",
                                                               positionAbbreviation: "LF",
                                                               atBats: "5",
                                                               runs: "0",
                                                               hits: "1",
                                                               runsBattedIn: "0",
                                                               baseOnBalls: "0",
                                                               strikeOuts: "1",
                                                               leftOnBase: "3",
                                                               average: ".250",
                                                               substitution: false)
        static let realmuto_20190424 = BoxscoreViewModel.Batter(name: "Realmuto",
                                                              positionAbbreviation: "C",
                                                              atBats: "3", runs: "1",
                                                              hits: "1",
                                                              runsBattedIn: "0",
                                                              baseOnBalls: "1",
                                                              strikeOuts: "1",
                                                              leftOnBase: "2",
                                                              average: ".282",
                                                              substitution: false)
        static let alonso_20190424 = BoxscoreViewModel.Batter(name: "c-Alonso",
                                                            positionAbbreviation: "PH-1B",
                                                            atBats: "1",
                                                            runs: "0",
                                                            hits: "0",
                                                            runsBattedIn: "0",
                                                            baseOnBalls: "0",
                                                            strikeOuts: "1",
                                                            leftOnBase: "1",
                                                            average: ".306",
                                                            substitution: true)

        
        static let viewModel = BoxscoreViewModel(homeTeamAbbreviation: "PHI",
                                                 homeNotes: ["c-Struck out for Smith, Do in the 8th", "d-Struck out for Rhame in the 9th."],
                                                 homeBatters: [mccutchen_20190424, realmuto_20190424, alonso_20190424, harper_20190424],
                                                 homeBattingTotals: ["32", "0", "6", "0", "3", "9", "19"])
    }
}
