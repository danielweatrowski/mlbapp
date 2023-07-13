//
//  SheetDestination.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/10/23.
//

import SwiftUI

@MainActor
extension View {
    func withRouterSheets(sheetItem: Binding<Sheet?>) -> some View {
        sheet(item: sheetItem) { sheet in
            switch sheet {
            case .videoPlayer(let url):
                VideoPlayerView(videoURL: url)
            }
        }
    }
}

enum Sheet: Identifiable {
    case videoPlayer(_ url: URL)
    
    var id: String {
        switch self {
        case .videoPlayer:
            return "videoPlayer"
        }
    }
}
