//
//  PitchSequenceView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 9/1/23.
//

import SwiftUI

struct PitchSequenceViewModel: Hashable {
    struct PitchRow: Hashable {
        let outcome: String
        let pitchNumber: Int
        let pitchColor: Color
        let pitchType: String
        let pitchSpeed: String
        let count: String
    }
    
    let rows: [PitchRow]
}

struct PitchSequenceView: View {
    
    let viewModel: PitchSequenceViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.rows, id: \.self) { row in
                rowView(for: row)
            }
            // TODO: Create ViewModifier that adds a divider if it's not the last element
        }
    }
    
    @ViewBuilder
    func rowView(for pitchRow: PitchSequenceViewModel.PitchRow) -> some View {
        HStack {
            Text(String(pitchRow.pitchNumber))
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
                .background(
                    Circle()
                        .fill(pitchRow.pitchColor)
                        .frame(width: 17, height: 17)
                )
                .frame(width: 17, height: 17)
            
            VStack(alignment: .leading) {
                Text(pitchRow.outcome)
                    .bold()
                Text("\(pitchRow.pitchType), \(pitchRow.pitchSpeed)")
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
            Spacer()
            Text(pitchRow.count)
                .font(.subheadline)
                .bold()
        }
    }
}
