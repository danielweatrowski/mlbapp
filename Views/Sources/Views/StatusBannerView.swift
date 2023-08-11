//
//  StatusBannerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import SwiftUI

public struct StatusBannerViewModel {
    public init(statusText: String, statusTextColor: Color = .black, secondaryStatusText: String? = nil, secondaryStatusTextColor: Color = .black, backgroundColor: Color, divider: Bool = false, chevronIndicator: Bool = true) {
        self.statusText = statusText
        self.statusTextColor = statusTextColor
        self.secondaryStatusText = secondaryStatusText
        self.secondaryStatusTextColor = secondaryStatusTextColor
        self.backgroundColor = backgroundColor
        self.divider = divider
        self.chevronIndicator = chevronIndicator
    }
    
    public let statusText: String
    public var statusTextColor: Color = .black
    public var secondaryStatusText: String?
    public var secondaryStatusTextColor: Color = .black
    public let backgroundColor: Color
    public var divider: Bool = false
    public var chevronIndicator: Bool = true
}

public struct StatusBannerView: View {
    
    public init(viewModel: StatusBannerViewModel) {
        self.viewModel = viewModel
    }

    public let viewModel: StatusBannerViewModel
    
    public var body: some View {
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
