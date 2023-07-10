//
//  VideosListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import SwiftUI

struct VideosListView: View {
    
    @StateObject var viewModel: VideosList.ViewModel
    let iteractor: VideosListBusinessLogic
    
    var body: some View {
        Group {
            ScrollView {
                LazyVStack {
                    VideosListRowView(viewModel: .init(id: "david-peralta-homers-7-on-a-fly-ball-to-right-field-j5x9qc",
                                                       title: "David Peralta's solo homer (7)",
                                                       description: "David Peralta launches a solo homer to right field in the bottom of the 7th inning to extend the Dodgers' lead to 10-4",
                                                       duration: "00:00:23",
                                                       thumbnailURLString: "https://img.mlbstatic.com/mlb-images/image/upload/w_215,h_121,f_jpg,c_fill,g_auto/mlb/glfyrsdzqsn3rky5dvwz.jpg",
                                                       urlString: "https://mlb-cuts-diamond.mlb.com/FORGE/2023/2023-07/08/64e61956-4c1f1627-7531ed43-csvm-diamondx64-asset_1280x720_59_4000K.mp4"))
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

extension VideosListView {
    static func configure(gameID: Int) -> VideosListView {
        let viewModel = VideosList.ViewModel()
        let presenter = VideosListPresenter(viewModel: viewModel)
        let interactor = VideosListInteractor(presenter: presenter, gameID: gameID)
        
        return VideosListView(viewModel: viewModel,
                              iteractor: interactor)
    }
}

// TODO: Remove
struct VideosListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView.configure(gameID: 0)
    }
}
