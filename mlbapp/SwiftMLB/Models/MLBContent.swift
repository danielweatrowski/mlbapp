//
//  MLBContent.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/14/23.
//

import Foundation

struct MLBContent: Decodable {
    
    struct Hightlight: Decodable {
        
        struct HighlightItems: Decodable {
            let items: [Item]
        }
        
        struct Item: Decodable {
            let id: String
            let type: String
            let date: String
            let title: String
            let description: String?
            let blurb: String
            let duration: String
            let playbacks: [Playback]?
            let image: Image?
        }
        
        
        struct Playback: Decodable {
            let name: String
            let url: String
        }
        
        struct Image: Decodable {
            let title: String
            let templateUrl: String
        }
        
        var highlights: HighlightItems
    }
    
    let highlights: Hightlight
}
