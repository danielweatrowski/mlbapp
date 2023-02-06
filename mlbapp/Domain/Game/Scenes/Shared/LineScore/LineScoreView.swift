//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LineScoreView: View {
    
    @Binding var viewModel: LineScoreViewModel?
    
    var body: some View {
        if let viewModel = viewModel {

            ScrollView {
                Grid {
                    GridRow {
                        ForEach(viewModel.headers, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .bold()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Divider()
                    GridRow {
                        ForEach(viewModel.homeLineItems, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .bold()
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                    
                    GridRow {
                        ForEach(viewModel.awayLineItems, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .bold()
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
        } else {
            EmptyView()
        }
    } 
}
