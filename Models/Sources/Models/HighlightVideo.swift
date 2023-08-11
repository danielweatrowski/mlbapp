//
//  HighlightVideo.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/10/23.
//

import Foundation

public struct HighlightVideo {
    
    public let id: String
    public let date: String
    public let title: String
    public let description: String?
    public let duration: String
    public let playbackURLString: String?
    public let thumnailURLTemplate: String?
        
    public var thumbnailURLString: String? {
        guard let templateURL = thumnailURLTemplate else {
            return nil
        }
        return templateURL.replacingOccurrences(of: "{formatInstructions}", with: "w_215,h_121,f_jpg,c_fill,g_auto,dpr_2.0")
    }
    
    public init(id: String, date: String, title: String, description: String? = nil, duration: String, playbackURLString: String? = nil, thumnailURLTemplate: String? = nil) {
        self.id = id
        self.date = date
        self.title = title
        self.description = description
        self.duration = duration
        self.playbackURLString = playbackURLString
        self.thumnailURLTemplate = thumnailURLTemplate
    }
}
