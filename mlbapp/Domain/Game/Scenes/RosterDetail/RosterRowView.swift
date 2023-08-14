//
//  RosterRowView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 7/1/23.
//

import SwiftUI

struct RosterRowViewModel: Identifiable {
    
    struct DetailItem {
        let id = UUID()
        let text: String
        let secondaryText: String
    }
    
    let id: UUID = UUID()
    var playerNumberText: String
    var playerNameText: String
    var playerPositionText: String
    var playerInfoText: String
    let details: [DetailItem]
}

struct RosterRowView: View {

    let viewModel: RosterRowViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            numberView
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(viewModel.playerNameText)
                        .bold()
                    Spacer()
                    Text(viewModel.playerPositionText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack {
                    
                    ForEach(viewModel.details, id: \.id) { detail in
                        Text(detail.text)
                            .font(.subheadline)
                        + Text(" \(detail.secondaryText)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if detail.id != viewModel.details.last?.id {
                            Divider()
                                .frame(height: 20)
                        }
                    }
                }
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            return viewDimensions[.listRowSeparatorLeading] + 38
        }
    }
    
    @ViewBuilder
    var numberView: some View {
        Text(viewModel.playerNumberText)
            .bold()
            .tintForeground()
//            .foregroundColor(.white)
//            .background(
//                Circle()
//                    .fill(.blue)
//                    .frame(width: 46, height: 46)
//            )
//            .frame(width: 46, height: 46, alignment: .center)
    }
}
