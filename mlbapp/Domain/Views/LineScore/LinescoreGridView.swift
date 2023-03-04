//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LinescoreGridView: View {
    
    @Binding var viewModel: LinescoreGridViewModel?
    
    var body: some View {
        if let viewModel = viewModel {
            
            ScrollView {
                Grid(verticalSpacing: 8) {
                    GridRow {
                        ForEach(viewModel.headers, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    GridRow {
                        ForEach(viewModel.homeLineItems, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: 36, alignment: .leading)

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
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: 36, alignment: .leading)
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
            .background()
            .cornerRadius(16)
        } else {
            EmptyView()
        }
    }
}
