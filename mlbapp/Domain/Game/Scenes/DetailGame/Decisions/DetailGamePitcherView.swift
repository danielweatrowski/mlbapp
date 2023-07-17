//
//  DetailPitcherView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/4/23.
//

import SwiftUI

struct GameDetailPitcherViewModel {
    struct DetailItem {
        let id = UUID()
        let text: String
        let secondaryText: String
    }
    
    let titleText: String
    let pitcherNameText: String
    let pitcherRecordText: String
    let details: [DetailItem]
}

struct DetailGamePitcherView: View {
    let viewModel: GameDetailPitcherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(viewModel.titleText)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .bold()
                Spacer()
            }
            
            HStack {
                Text(viewModel.pitcherNameText)
                    .bold()
                + Text(" \(viewModel.pitcherRecordText)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .bold()
            }
            
            HStack {
                ForEach(viewModel.details, id: \.id) { detail in
                    Group {
                        Text(detail.text)
                        + Text(" \(detail.secondaryText)")
                            .foregroundColor(.secondary)
                            .font(.footnote)
                            .bold()
                    }
                    
                    if detail.id != viewModel.details.last?.id {
                        Divider()
                            .padding(.horizontal)
                            .frame(height: 20)
                    }
                }
            }
            .frame(height: 20)
        }
    }
}
