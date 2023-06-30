//
//  StatusBannerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import SwiftUI

struct StatusBannerView: View {
    let statusText: String
    var statusTextColor: Color = .primary
    var secondaryStatusText: String?
    var secondaryStatusTextColor: Color = .primary
    let backgroundColor: Color
    var divider: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(statusText)
                    .bold()
                    .foregroundColor(statusTextColor)
                    .font(.subheadline)
                
                if let secondaryStatusText = secondaryStatusText {
                    Spacer()
                    Text(secondaryStatusText)
                        .font(.subheadline)
                        .foregroundColor(secondaryStatusTextColor)
                    
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(backgroundColor)
        }
        
        if divider {
            Divider()
        }
    }
}
