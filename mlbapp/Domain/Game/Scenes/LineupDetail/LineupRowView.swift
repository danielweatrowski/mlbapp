//
//  LineupRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/21/23.
//

import SwiftUI

struct LineupRowViewModel: Hashable {
    let id: UUID = UUID()
    var playerBattingIndex: Int
    var playerNameText: String
    var playerPositionText: String
    var playerInfoText: String
}

struct LineupRowView: View {

    let viewModel: LineupRowViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Image(systemName: "\(viewModel.playerBattingIndex).circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.playerNameText)
                    .bold()
                Text(viewModel.playerPositionText)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
