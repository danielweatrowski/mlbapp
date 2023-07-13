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
        DispatchQueue.main.async {
            viewModel.videoRows = [.init(id: "david-peralta-homers-7-on-a-fly-ball-to-right-field-j5x9qc",
                                                                                          title: "David Peralta's solo homer (7)",
                                                                                          description: "David Peralta launches a solo homer to right field in the bottom of the 7th inning to extend the Dodgers' lead to 10-4",
                                                                                          duration: "00:00:23",
                                                                                          thumbnailURLString: "https://img.mlbstatic.com/mlb-images/image/upload/w_270,h_154,f_jpg,c_fill,g_auto/mlb/glfyrsdzqsn3rky5dvwz.jpg",
                                                                                          urlString: "https://mlb-cuts-diamond.mlb.com/FORGE/2023/2023-07/08/64e61956-4c1f1627-7531ed43-csvm-diamondx64-asset_1280x720_59_4000K.mp4")]
        }
    }
    
    func presentSceneError(_ sceneError: SceneError) {
        DispatchQueue.main.async {
            self.viewModel.sceneError.presentAlert(sceneError)
        }
    }
}
