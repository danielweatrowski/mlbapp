//
//  SummaryGameView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 4/21/23.
//

import SwiftUI

struct SummaryGameView: View {
    
    @StateObject var viewModel: SummaryGame.ViewModel
    let interactor: SummaryGameBusinessLogic?
    
    @State var selection: Int = 0
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loaded:
                    List {
                        ForEach(viewModel.sections, id: \.id) { section in
                            Section(header: Text(section.inningName)) {
                                ForEach(section.plays, id: \.id) { playVM in
                                    SummaryGamePlayView(viewModel: playVM)
                                }
                            }
                        }
                    }
                case .loading:
                    ProgressView()
                case .error:
                    EmptyView()
                }
            }
            VStack(spacing: 0) {
                Spacer()
                toolbar
            }
        }
        .withSceneError($viewModel.sceneError)
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor?.loadGameSummary()
        }
    }
    
    @ViewBuilder
    var toolbar: some View {
        HStack(alignment: .center, spacing: 0) {
            Picker("Play Picker", selection: $selection) {
                Text("All").tag(0)
                Text("Home").tag(1)
                Text("Away").tag(2)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            Menu {
                Picker(selection: $viewModel.filterType, label: Text("Filter Plays")) {
                    ForEach(SummaryGame.FilterType.allCases) { option in
                         Text(String(describing: option))
                     }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding(.trailing)
        }
        .frame(height: 40)

        .padding(.vertical, 4)
        .background(.ultraThickMaterial)
        
    }
}

extension SummaryGameView {
    static func configure(gameID: Int) -> Self {
        let viewModel = SummaryGame.ViewModel(gameID: gameID)
        let presenter = SummaryGamePresenter(viewModel: viewModel)
        let interactor = SummaryGameInteractor(presenter: presenter, gameID: gameID)
        return SummaryGameView(viewModel: viewModel, interactor: interactor)
    }
}
