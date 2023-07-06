//
//  StandingsListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/4/23.
//

import SwiftUI


struct StandingsListView: View {
    
    @StateObject var viewModel: StandingsList.ViewModel
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loaded:
                standingsList
            default: EmptyView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                HStack(alignment: .center) {
                    Picker(selection: $viewModel.selectedLeague, label: Text("League")) {
                        Text(ActiveLeague.national.nameShort)
                            .tag(0)
                        Text(ActiveLeague.american.nameShort)
                            .tag(1)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle(viewModel.navigationTitle)
        .withSceneError($viewModel.sceneError)
        
    }
    
    @ViewBuilder
    var standingsList: some View {
        List {
            ForEach(ActiveLeague.national.divisions, id: \.rawValue) { division in
                Section(division.nameShort) {
                    Grid {
                        StandingsHeaderRowView()
                        Divider()
                        GridRow {
                            Text("LAD")
                                .frame(width: 46, alignment: .leading)
                                .bold()
                            Text("50")
                            Text("37")
                            Text(".560")
                            Text("2.5")
                            Text("6-4")
                            Text("W1")
                        }
                        Divider()
                        GridRow {
                            Text("SF")
                                .frame(width: 46, alignment: .leading)
                                .bold()
                            Text("50")
                            Text("37")
                            Text(".560")
                            Text("2.5")
                            Text("6-4")
                            Text("L1")
                        }
                    }
                }
            }
        }
    }
}

extension StandingsListView {
    static func configure() -> Self {
        let viewModel = StandingsList.ViewModel()
        return StandingsListView(viewModel: viewModel)
    }
}
