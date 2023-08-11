//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI
import Common

public struct LinescoreGridView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var interfaceSize: InterfaceSize {
        return InterfaceSize(horizontalSizeClass: horizontalSizeClass, verticalSizeClass: verticalSizeClass)
    }
    
    var viewModel: LinescoreGridViewModel?
    var embedInScrollView: Bool
    
    public init(viewModel: LinescoreGridViewModel? = nil, embedInScrollView: Bool) {
        self.viewModel = viewModel
        self.embedInScrollView = embedInScrollView
    }
    
    public var body: some View {
        if let viewModel = viewModel {
            
            if interfaceSize.portrait, embedInScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    linescoreGrid(with: viewModel)
                }
            } else {
                linescoreGrid(with: viewModel)
            }

        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func linescoreGrid(with viewModel: LinescoreGridViewModel) -> some View {
        Grid(verticalSpacing: 8) {
            GridRow {
                ForEach(viewModel.headers, id: \.id) { item in
                    switch(item.type) {
                    case .team:
                        Text(item.value)
                            .bold()
                            .font(.subheadline)
                    case .none:
                        EmptyGridItem()
                    default:
                        Text(item.value)
                            .bold()
                            .font(.subheadline)
                    }
                }
            }
            //Divider()
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
    }
}
