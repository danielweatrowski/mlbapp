//
//  CurrentPlayView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 6/10/23.
//

import SwiftUI

struct CurrentPlayView: View {
    let viewModel: CurrentPlayViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
    
            VStack(alignment: .center, spacing: 24) {
                
                // TODO: Make Diamond
                VStack {
                    Rectangle()
                        .fill(viewModel.isRunnerOn1B ? .blue : .secondary)
                        .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                        .rotationEffect(Angle(degrees: 45))
                        .padding(.bottom, -10)
                    
                    HStack(spacing: 20) {
                        Rectangle()
                            .fill(viewModel.isRunnerOn2B ? .blue : .secondary)
                            .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                            .rotationEffect(Angle(degrees: 45))
                        
                        Rectangle()
                            .fill(viewModel.isRunnerOn3B ? .blue : .secondary)
                            .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                            .rotationEffect(Angle(degrees: 45))
                    }
                }
                
                VStack {
                    // Out indicators
                    HStack {
                        ForEach(1..<4, id: \.self) { outNumber in
                            Circle()
                                .fill(color(forOutNumber: outNumber))
                                .frame(width: viewModel.outIndicatorWidth, height: viewModel.outIndicatorWidth)
                        }
                    }
                    
                    // Count label
                    Text(viewModel.countText)
                        .bold()
                }
            }
            .padding(.trailing)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.batterTitleText)
                        .font(.footnote)
                    Text(viewModel.batterNameText)
                        .bold()
                    Text(viewModel.batterStatsText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                //.frame(maxWidth: .infinity, alignment: .leading)
                VStack(alignment: .leading, spacing: 2) {
                    Text(viewModel.pitcherTitleText)
                        .font(.footnote)
                    Text(viewModel.pitcherNameText)
                        .bold()
                    Text(viewModel.pitcherStatsText)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
               // .frame(maxWidth: .infinity, alignment: .leading)

            }
        }
        .padding()
        .padding([.leading, .top])
    }
    
    func color(forOutNumber out: Int) -> Color {
        let numberOfOuts = viewModel.numberOfOuts
        
        return numberOfOuts >= out
        ? .yellow
        : .secondary
        
        // outNumber, numberOfOuts -> Color
        // 1, 0 -> secondary
        // 2, 0 -> secondary
        // 3, 0 -> secondary
        
        // 1, 1 -> yellow
        // 2, 1 -> secondary
        // 3, 1 -> secondary
        
        // 1, 2 -> yellow
        // 2, 2 -> yellow
        // 3, 2 -> secondary
        
        // 1, 3 -> yellow
        // 2, 3 -> yellow
        // 3, 3 -> yellow

    }
}

//struct CurrentPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentPlayView()
//    }
//}
