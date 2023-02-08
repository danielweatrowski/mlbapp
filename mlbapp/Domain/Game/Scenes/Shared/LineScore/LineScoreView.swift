//
//  LineScoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 11/6/22.
//

import SwiftUI

struct LineScoreView: View {
    
    @Binding var viewModel: LineScoreViewModel?
    
    var body: some View {
        if let viewModel = viewModel {

            ScrollView {
                Grid(verticalSpacing: 8) {
                    GridRow {
                        ForEach(viewModel.headers, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            default:
                                Text(item.value)
                                    .bold()
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    //Divider()
                    GridRow {
                        ForEach(viewModel.homeLineItems, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .font(.subheadline)
                                    .bold()
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                    GridRow {
                        ForEach(viewModel.awayLineItems, id: \.id) { item in
                            switch(item.type) {
                            case .team:
                                Text(item.value)
                                    .font(.subheadline)
                                    .bold()
                            case .none:
                                EmptyGridItem()
                            default:
                                Text(item.value)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Divider()
                        .padding(.vertical, 8)
                }
                
                pitchersBox
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var pitchersBox: some View {
        if let winnersName = viewModel?.winningPitcherName,
           let winningERA = viewModel?.winningPitcherERA,
           let winningRecord = viewModel?.winningPitcherRecord,
           let losingName = viewModel?.losingPitcherName,
           let losingERA = viewModel?.losingPitcherERA,
           let losingRecord = viewModel?.losingPitcherRecord {
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("W:")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(winnersName)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Text(winningRecord)
                            .font(.footnote)
                        Divider()
                        Text("\(winningERA) ERA")
                            .font(.footnote)
                        Spacer()
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("L:")
                            .bold()
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(losingName)
                            .bold()
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Text(losingRecord)
                            .font(.footnote)
                        Divider()
                        Text("\(losingERA) ERA")
                            .font(.footnote)
                        Spacer()
                    }
                }
                Spacer()
            }
        } else {
            Text("No decision data.")
                .foregroundColor(.secondary)
                .font(.subheadline)
        }
    }
}
