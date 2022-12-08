//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LineScoreView: View {
    
    @Binding var viewModel: LineScoreViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 8) {
                ForEach(viewModel.headers, id: \.id) { item in
                    switch(item.type) {
                    case .team:
                        Text(item.value)
                            .bold()
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    default:
                        Text(item.value)
                            .font(.subheadline)
                            .fixedSize(horizontal: true, vertical: false)

                    }
                }
            }
            Divider()
            LazyVGrid(columns: viewModel.columns, spacing: 8) {
                ForEach(viewModel.data, id: \.id) { item in
                    switch(item.type) {
                    case .team:
                        Text(item.value)
                            .bold()
                            .fixedSize(horizontal: true, vertical: false)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    default:
                        Text(item.value)
                            .font(.subheadline)
                            .fixedSize(horizontal: true, vertical: false)

                    }
                }
            }
        }
    }
}
