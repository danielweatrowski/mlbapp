//
//  HighlightVideo.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/10/23.
//

import Foundation

struct HighlightVideo {
    let id: String
    let date: String
    let title: String
    let description: String?
    let duration: String
    let playbackURLString: String?
    let thumnailURLTemplate: String?
        
    var thumbnailURLString: String? {
        guard let templateURL = thumnailURLTemplate else {
            return nil
        }
        return templateURL.replacingOccurrences(of: "{formatInstructions}", with: "w_215,h_121,f_jpg,c_fill,g_auto,dpr_2.0")
    }
}
