//
//  VideosListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import SwiftUI
import Views
import Common

struct VideosListView: View {
    
    @StateObject var viewModel: VideosList.ViewModel
    let interactor: VideosListBusinessLogic
    
    @EnvironmentObject var sceneProvider: SceneProvider
        
    var body: some View {
        Group {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.videoRows, id: \.id) { rowViewModel in
                        VideosListRowView(viewModel: rowViewModel)
                            .onTapGesture {
                                let url = URL(string: rowViewModel.urlString)!
                                sceneProvider.present(scene: .videoPlayer(url))
                            }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .background(Color(uiColor: .systemGroupedBackground))
        .task {
            await interactor.loadVideos()
        }
    }
}

extension VideosListView {
    static func configure(gameID: Int) -> VideosListView {
        let viewModel = VideosList.ViewModel()
        let presenter = VideosListPresenter(viewModel: viewModel)
        let interactor = VideosListInteractor(presenter: presenter, gameID: gameID)
        
        return VideosListView(viewModel: viewModel,
                              interactor: interactor)
    }
}
