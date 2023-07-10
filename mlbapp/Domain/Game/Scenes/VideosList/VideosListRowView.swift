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
    
    let viewModel: VideosListRowViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.thumbnailURLString)) { image in
                image
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fit)
                    .border(.secondary)
                    .cornerRadius(12)

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
        .background()
        .cornerRadius(12)
        
    }
}
