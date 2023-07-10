//
//  SummaryGamePlayView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/13/23.
//

import SwiftUI

struct SummaryGamePlayView: View {
    
    var viewModel: SummaryGame.InningPlayViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(viewModel.eventName)
                        .foregroundColor(.blue)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(viewModel.time)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Text(viewModel.description)
            }
        }
    }
}
