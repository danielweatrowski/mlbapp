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
        VStack {
            currentPlayHeaderView
            
            if let onDeckBatterName = viewModel.onDeckBatterNameText {
                onDeckView(batterName: onDeckBatterName)
            }
            
            if let pitchSequenceVM = viewModel.pitchSequenceViewModel {
                PitchSequenceView(viewModel: pitchSequenceVM)
            }
        }
    }
    
    @ViewBuilder
    func onDeckView(batterName: String) -> some View {
        Divider()
        HStack(alignment: .center, spacing: 2) {
            Text(viewModel.onDeckTitleText)
            Text(batterName)
                .bold()
        }
        .font(.footnote)
        Divider()
    }
    
    @ViewBuilder var currentPlayHeaderView: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.pitcherTitleText)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(viewModel.pitcherNameText)
                    .bold()
                    .font(.title2)
                VStack(alignment: .leading) {
                    Text(viewModel.pitcherStatsText1)
                    Text(viewModel.pitcherStatsText2)
                }
                .padding(.top, 2)
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack(alignment: .center, spacing: 16) {
                diamondView
                numberOfOutsView
                Text(viewModel.countText)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .center)

            VStack(alignment: .trailing, spacing: 2) {
                Text(viewModel.batterTitleText)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                Text(viewModel.batterNameText)
                    .bold()
                    .font(.title2)
                VStack(alignment: .trailing) {
                    Text(viewModel.batterStatsText1)
                    Text(viewModel.batterStatsText2)
                }
                .padding(.top, 2)
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    @ViewBuilder
    var diamondView: some View {
        // TODO: Make Diamond
        VStack {
            Rectangle()
                .fill(viewModel.isRunnerOn1B ? .blue : Color(uiColor: .tertiaryLabel))
                .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                .rotationEffect(Angle(degrees: 45))
                .padding(.bottom, -10)
            
            HStack(spacing: 13) {
                Rectangle()
                    .fill(viewModel.isRunnerOn2B ? .blue : Color(uiColor: .tertiaryLabel))
                    .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                    .rotationEffect(Angle(degrees: 45))
                
                Rectangle()
                    .fill(viewModel.isRunnerOn3B ? .blue : Color(uiColor: .tertiaryLabel))
                    .frame(width: viewModel.baseIndicatorWidth, height: viewModel.baseIndicatorWidth)
                    .rotationEffect(Angle(degrees: 45))
            }
        }
    }
    
    @ViewBuilder
    var numberOfOutsView: some View {
        HStack {
            ForEach(1..<4, id: \.self) { outNumber in
                Circle()
                    .fill(color(forOutNumber: outNumber))
                    .frame(width: viewModel.outIndicatorWidth, height: viewModel.outIndicatorWidth)
            }
        }
    }
    
    func color(forOutNumber out: Int) -> Color {
        let numberOfOuts = viewModel.numberOfOuts
        
        return numberOfOuts >= out
        ? .yellow
        : Color(uiColor: .tertiaryLabel)
        
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

struct CurrentPlayView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = CurrentPlayViewModel(batterNameText: "Slugger, D",
                                      batterStatsText1: "1-1, 2B",
                                      batterStatsText2: ".200 AVG",
                                      pitcherNameText: "Cannon, S",
                                      pitcherStatsText1: "1.0 IP, 20 P",
                                      pitcherStatsText2: "4K, 1 ER",
                                      countText: "1-1",
                                      pitchSequenceRows: [],
                                      onDeckBatterNameText: nil)
        ScrollView {
            CurrentPlayView(viewModel: vm)
                .padding()
        }
    }
}
