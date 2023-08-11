//
//  VideoPlayerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/10/23.
//

import SwiftUI
import AVKit

public struct VideoPlayerView: View {
    
    public let videoURL: URL
    
    var player: AVPlayer {
        return AVPlayer(url: videoURL)
    }
    
    public init(videoURL: URL) {
        self.videoURL = videoURL
    }
    
    public var body: some View {
        VStack {
            VideoPlayer(player: player)
                .ignoresSafeArea()
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoURL: URL(string: "https://mlb-cuts-diamond.mlb.com/FORGE/2023/2023-07/08/64e61956-4c1f1627-7531ed43-csvm-diamondx64-asset_1280x720_59_4000K.mp4")!)
    }
}
