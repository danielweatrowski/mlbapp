//
//  VideosListPresenter.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

protocol VideosListPresentationLogic: SceneErrorPresentable {
    func presentVideos(output: VideosList.Output)
}

struct VideosListPresenter: VideosListPresentationLogic {

    let viewModel: VideosList.ViewModel
    
    func presentVideos(output: VideosList.Output) {
        
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        
    }
}
