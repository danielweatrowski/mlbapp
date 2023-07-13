//
//  VideosList.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

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
