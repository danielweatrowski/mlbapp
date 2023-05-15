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

struct SummaryGamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryGamePlayView(viewModel: .init(playID: 1, eventName: "Home Run", description: "Freddie Freeman homers (19) on a fly ball to center field. Trea Turner scores.", time: "4:40 PM", numberOfOuts: nil))
    }
}
