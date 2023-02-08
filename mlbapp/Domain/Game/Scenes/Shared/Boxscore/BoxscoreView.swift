//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import SwiftUI

struct EmptyGridItem: View {
    let color: Color = .clear
    
    var body: some View {
        color
            .frame(width: 20, height: 20)
    }
}

struct BoxscoreView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var interfaceSize: InterfaceSize {
        return InterfaceSize(horizontalSizeClass: horizontalSizeClass, verticalSizeClass: verticalSizeClass)
    }
    
    @Binding var viewModel: BoxscoreViewModel?
    @State private var teamBoxSelection = 0

    var body: some View {
        if let viewModel = viewModel {
            VStack {
                
                Picker("Teams", selection: $teamBoxSelection) {
                    Text(viewModel.homeTeamAbbreviation).tag(0)
                    Text(viewModel.awayTeamAbbreviation).tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                
                // boxscore content
                if interfaceSize.portrait {
                    ScrollView(.horizontal) {
                        boxscore(for: viewModel)
                    }
                    .padding(.bottom, 16)
                } else {
                    boxscore(for: viewModel)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    ForEach(viewModel.homeNotes, id: \.self) {
                        Text($0)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Batting")
                        .font(.subheadline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(viewModel.homeBattingInfo, id: \.title) { item in
                        Group {
                            Text(item.title)
                                .font(.subheadline)
                                .bold()
                            + Text(" ")
                            + Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.vertical)
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Fielding")
                        .font(.subheadline)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ForEach(viewModel.homeFieldingInfo, id: \.title) { item in
                        Group {
                            Text(item.title)
                                .font(.subheadline)
                                .bold()
                            + Text(" ")
                            + Text(item.description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.vertical)
            }
//            .onAppear {
//                print("Horizontal: \(horizontalSizeClass)")
//                print("Vertical: \(verticalSizeClass)")
//            }
        }
        else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private func boxscore(for viewModel: BoxscoreViewModel) -> some View {
        Grid(verticalSpacing: 16) {
            
            BoxscoreHeaderView(teamAbbreviation: selectedTeamAbbreviation)
            
            Divider()
            
            ForEach(selectedBatters, id: \.id) { batter in
                BoxscoreRowView(viewModel: batter, type: .batter)
            }
            
            BoxscoreRowView(viewModel: viewModel.homeBattingTotals, type: .total)
                .padding(.top)
        }
    }
    
    private var selectedTeamAbbreviation: String {
        return teamBoxSelection == 0
        ? viewModel?.homeTeamAbbreviation ?? ""
        : viewModel?.awayTeamAbbreviation ?? ""
    }
    
    private var selectedBatters: [BoxscoreViewModel.Batter] {
        return teamBoxSelection == 0
        ? viewModel?.homeBatters ?? []
        : viewModel?.awayBatters ?? []
    }
    
    private var selectedTotals: BoxscoreViewModel.Batter {
        return teamBoxSelection == 0
        ? viewModel?.homeBattingTotals ?? BoxscoreViewModel.emptyTotals
        : viewModel?.awayBattingTotals ?? BoxscoreViewModel.emptyTotals
    }
}

struct BoxscoreView_Previews: PreviewProvider {
    static var previews: some View {
        BoxscoreView(viewModel: .constant(BoxscoreViewModel.Seed.viewModel))
    }
}
