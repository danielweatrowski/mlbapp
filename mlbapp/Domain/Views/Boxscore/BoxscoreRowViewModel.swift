//
//  BoxscoreRowViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/13/23.
//

import Foundation

struct BoxscoreRowViewModel {
    
    let id = UUID()
    let title: String
    let subtitle: String
    let indentTitle: Bool
    let boldItems: Bool
    let item0: String
    let item1: String
    let item2: String
    let item3: String
    let item4: String
    let item5: String
    let item6: String
    let item7: String
    
    init(title: String, subtitle: String, indentTitle: Bool = false, boldItems: Bool = false, item0: String, item1: String, item2: String, item3: String, item4: String, item5: String, item6: String, item7: String) {
        self.title = title
        self.subtitle = subtitle
        self.indentTitle = indentTitle
        self.boldItems = boldItems
        self.item0 = item0
        self.item1 = item1
        self.item2 = item2
        self.item3 = item3
        self.item4 = item4
        self.item5 = item5
        self.item6 = item6
        self.item7 = item7
    }
}
