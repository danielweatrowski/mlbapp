//
//  BoxscoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import Foundation

public struct BoxscoreGridViewModel {
    
    public init(homeTeamAbbreviation: String, homeNotes: [String], homeRows: [BoxscoreRowViewModel], homeTotalsRow: BoxscoreRowViewModel, awayTeamAbbreviation: String, awayNotes: [String], awayRows: [BoxscoreRowViewModel], awayTotalsRow: BoxscoreRowViewModel, type: BoxscoreGridViewModel.BoxType) {
        self.homeTeamAbbreviation = homeTeamAbbreviation
        self.homeNotes = homeNotes
        self.homeRows = homeRows
        self.homeTotalsRow = homeTotalsRow
        self.awayTeamAbbreviation = awayTeamAbbreviation
        self.awayNotes = awayNotes
        self.awayRows = awayRows
        self.awayTotalsRow = awayTotalsRow
        self.type = type
    }
    
    
    public enum BoxType {
        case batters, pitchers
        
        var header: BoxscoreRowViewModel {
            switch self {
            case .batters: return BoxscoreRowViewModel(title: "Batters",
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
                
            case .pitchers: return BoxscoreRowViewModel(title: "Pitchers",
                                                        subtitle: "",
                                                        boldItems: true,
                                                        item0: "IP",
                                                        item1: "H",
                                                        item2: "R",
                                                        item3: "ER",
                                                        item4: "BB",
                                                        item5: "SO",
                                                        item6: "HR",
                                                        item7: "ERA")
            }
        }
    }
    
    public var homeTeamAbbreviation: String
    public var homeNotes: [String]
    public var homeRows: [BoxscoreRowViewModel]
    public var homeTotalsRow: BoxscoreRowViewModel
    public var awayTeamAbbreviation: String
    public var awayNotes: [String]
    public var awayRows: [BoxscoreRowViewModel]
    public var awayTotalsRow: BoxscoreRowViewModel
    
    public var type: BoxType
    
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
    
    func bitchingHeader(withTitle title: String) -> BoxscoreRowViewModel {
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
