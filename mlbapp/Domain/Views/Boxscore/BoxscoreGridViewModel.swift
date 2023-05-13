//
//  BoxscoreViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/23/23.
//

import Foundation

struct BoxscoreGridViewModel {
    
    enum BoxType {
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
    
    var homeTeamAbbreviation: String
    var homeNotes: [String]
    var homeRows: [BoxscoreRowViewModel]
    var homeTotalsRow: BoxscoreRowViewModel
    var awayTeamAbbreviation: String
    var awayNotes: [String]
    var awayRows: [BoxscoreRowViewModel]
    var awayTotalsRow: BoxscoreRowViewModel
    
    var type: BoxType
    
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
