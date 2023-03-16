//
//  BoxscoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import Foundation

struct BoxscoreViewModel {
    
    var homeTeamAbbreviation: String
    var homeNotes: [String]
    var homeRows: [BoxscoreRowViewModel]
    var homeTotalsRow: BoxscoreRowViewModel
    var awayTeamAbbreviation: String
    var awayNotes: [String]
    var awayRows: [BoxscoreRowViewModel]
    var awayTotalsRow: BoxscoreRowViewModel
    
    func battingHeader(withTitle title: String) -> BoxscoreRowViewModel {
        return BoxscoreRowViewModel(title: title,
                                    subtitle: "",
                                    boldItems: true,
                                    item0: "AB",
                                    item1: "R",
                                    item2: "H",
                                    item3: "RBI",
                                    item4: "BB",
                                    item5: "SO",
                                    item6: "LOB",
                                    item7: "AVG")
    }
}

extension BoxscoreViewModel {
    /*
    static func buildBattingTotals(atBats: String, runs: String, hits: String, runsBattedIn: String, baseOnBalls: String, strikeOuts: String, leftOnBase: String) -> Batter {
        return .init(name: "Totals",
                     positionAbbreviation: "",
                     atBats: atBats,
                     runs: runs,
                     hits: hits,
                     runsBattedIn: runsBattedIn,
                     baseOnBalls: baseOnBalls,
                     strikeOuts: strikeOuts,
                     leftOnBase: leftOnBase,
                     average: "",
                     substitution: false)
    }

    static let emptyTotals = BoxscoreViewModel.buildBattingTotals(atBats: "0",
                                                                  runs: "0",
                                                                  hits: "0",
                                                                  runsBattedIn: "0",
                                                                  baseOnBalls: "0",
                                                                  strikeOuts: "0",
                                                                  leftOnBase: "0")
     
     */
}
