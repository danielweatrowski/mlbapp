//
//  RosterRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI

struct RosterRowViewModel: Hashable {
    let id: UUID = UUID()
    var playerNumberText: String
    var playerNameText: String
    var playerPositionText: String
    var playerInfoText: String
}

struct RosterRowView: View {

    let viewModel: RosterRowViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            numberView
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.playerNameText)
                    .bold()
                Text(viewModel.playerPositionText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return viewDimensions[.listRowSeparatorLeading] + 38
        }
    }
    
    @ViewBuilder
    var numberView: some View {
        Text(viewModel.playerNumberText)
            .font(.subheadline)
            .bold()
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(.blue)
                    .frame(width: 25, height: 25)
            )
            .frame(width: 25, height: 25)
    }
}
