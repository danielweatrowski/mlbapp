//
//  VideosListInteractor.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import Foundation

protocol VideosListBusinessLogic {
    func loadVideos() async
}

protocol VideosListDataStore {
    var gameID: Int { get }
}

struct VideosListInteractor: VideosListBusinessLogic & VideosListDataStore {
    
    let gameWorker = GameWorker(store: MLBAPIRepository())
    let presenter: VideosListPresentationLogic
    var gameID: Int
    
    func loadVideos() async {
        do {
            let videos = try await gameWorker.fetchHighlightVideos(forGameID: gameID)
            let output = VideosList.Output(videos: videos)
            
            presenter.presentVideos(output: output)
        } catch {
            let sceneError = SceneError(errorDescription: error.localizedDescription)
            presenter.presentSceneError(sceneError)
        }
    }
    
}
