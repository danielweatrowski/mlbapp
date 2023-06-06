//
//  DetailPitcherView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import SwiftUI

struct DetailGamePitcherView: View {
    let titleText: String
    var titleColor: Color = .secondary
    let pitcherNameText: String
    let pitcherInfoText: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(titleText)
                    .font(.subheadline)
                    .foregroundColor(titleColor)
                Spacer()
            }
            HStack {
                Text(pitcherNameText)
                    .bold()
                Spacer()
                Text(pitcherInfoText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
