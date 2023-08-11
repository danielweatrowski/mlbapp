//
//  BoxscoreRowViewModel.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 3/13/23.
//

import Foundation

public struct BoxscoreRowViewModel {
    
    public let id = UUID()
    public let title: String
    public let subtitle: String
    public let indentTitle: Bool
    public let boldItems: Bool
    public let item0: String
    public let item1: String
    public let item2: String
    public let item3: String
    public let item4: String
    public let item5: String
    public let item6: String
    public let item7: String
    
    public init(title: String, subtitle: String, indentTitle: Bool = false, boldItems: Bool = false, item0: String, item1: String, item2: String, item3: String, item4: String, item5: String, item6: String, item7: String) {
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
