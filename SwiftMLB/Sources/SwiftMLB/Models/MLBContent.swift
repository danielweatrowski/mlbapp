//
//  MLBContent.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/14/23.
//

import Foundation

public struct MLBContent: Decodable {
    
    public struct Hightlight: Decodable {
        
        public struct HighlightItems: Decodable {
            public let items: [Item]
        }
        
        public struct Item: Decodable {
            public let id: String
            public let type: String
            public let date: String
            public let title: String
            public let description: String?
            public let blurb: String
            public let duration: String
            public let playbacks: [Playback]?
            public let image: Image?
        }
        
        
        public struct Playback: Decodable {
            public let name: String
            public let url: String
        }
        
        public struct Image: Decodable {
            public let title: String
            public let templateUrl: String
        }
        
        public var highlights: HighlightItems
    }
    
    public let highlights: Hightlight
}
