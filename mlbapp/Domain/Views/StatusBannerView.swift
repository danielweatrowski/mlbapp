//
//  StatusBannerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import SwiftUI

struct StatusBannerViewModel {
    let statusText: String
    var statusTextColor: Color = .primary
    var secondaryStatusText: String?
    var secondaryStatusTextColor: Color = .primary
    let backgroundColor: Color
    var divider: Bool = false
    var chevronIndicator: Bool = true
}

struct StatusBannerView: View {

    let viewModel: StatusBannerViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(viewModel.statusText)
                    .bold()
                    .foregroundColor(viewModel.statusTextColor)
                    .font(.subheadline)
                
                if let secondaryStatusText = viewModel.secondaryStatusText {
                    Spacer()
                    Text(secondaryStatusText)
                        .font(.subheadline)
                        .foregroundColor(viewModel.secondaryStatusTextColor)
                    
                }
                if viewModel.chevronIndicator {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(viewModel.backgroundColor)
        }
        
        if viewModel.divider {
            Divider()
        }
    }
}
