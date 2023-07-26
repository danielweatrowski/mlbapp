//
//  VideosListRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/9/23.
//

import SwiftUI

struct VideosListRowViewModel: Hashable {
    let id: String
    let title: String
    let description: String
    let duration: String
    let thumbnailURLString: String
    let urlString: String
}

struct VideosListRowView: View {
    
    @EnvironmentObject private var theme: Theme
    let viewModel: VideosListRowViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.thumbnailURLString)) { image in
                ZStack {
                    image
                        .resizable()
                        .aspectRatio(16/9, contentMode: .fit)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.secondary, lineWidth: 0.5)
                        )
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            durationView
                                .padding(12)
                        }
                    }
                }

            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 8)
            
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 2)
                .bold()
                
            Text(viewModel.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
        .padding()
        .applyThemeSecondaryBackround(theme)
        .cornerRadius(12)
        
    }
    
    @ViewBuilder
    var durationView: some View {
        Text(viewModel.duration)
            .foregroundColor(.white)
            .font(.caption)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                Capsule()
                    .fill(.black)
            )
    }
}
