//
//  LineScoreViewItem.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 12/7/22.
//

import Foundation

struct LineScoreViewItem: Identifiable {
    enum ItemType {
        case team, header, run, stat, none
    }
    
    var id = UUID()
    var type: ItemType
    var value: String
    
    mutating func setValue(_ value: String) {
        self.value = value
    }
}
