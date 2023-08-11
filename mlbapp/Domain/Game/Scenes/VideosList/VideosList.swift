//
//  VideosList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation
import Models
import Common

enum VideosList {
    
    class ViewModel: ObservableObject {
        let navigationTitle: String = "Videos"
        
        @Published
        var videoRows: [VideosListRowViewModel] = []
        
        @Published
        var sceneError: SceneError = SceneError()
    }
    
    struct Output {
        let videos: [HighlightVideo]
    }
}
