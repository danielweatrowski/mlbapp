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
        
        let rows: [VideosListRowViewModel] = output.videos.compactMap { highlight in
            guard let description = highlight.description else {
                return nil
            }
            return VideosListRowViewModel(id: highlight.id,
                                          title: highlight.title,
                                          description: description,
                                          duration: highlight.duration,
                                          thumbnailURLString: highlight.thumbnailURLString ?? "",
                                          urlString: highlight.playbackURLString ?? "")
        }
        
        DispatchQueue.main.async {
            viewModel.videoRows = rows
        }
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
}
