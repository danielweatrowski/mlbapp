//
//  StatusBannerView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/5/23.
//

import SwiftUI

struct StatusBannerView: View {
    let statusText: String
    let backgroundColor: Color
    
    var body: some View {
        HStack {
            Text(statusText)
                .bold()
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(backgroundColor)
        }
    }
}
