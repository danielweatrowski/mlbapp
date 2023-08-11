//
//  BoxscoreView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 1/16/23.
//

import SwiftUI
import Common

struct EmptyGridItem: View {
    let color: Color = .clear
    
    var body: some View {
        color
            .frame(width: 20, height: 20)
    }
}

public struct BoxscoreGridView: View {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    var interfaceSize: InterfaceSize {
        return InterfaceSize(horizontalSizeClass: horizontalSizeClass, verticalSizeClass: verticalSizeClass)
    }
    
    public init(viewModel: BoxscoreGridViewModel? = nil, teamBoxSelection: Binding<Int>) {
        self.viewModel = viewModel
        self._teamBoxSelection = teamBoxSelection
    }
    
    var viewModel: BoxscoreGridViewModel?
    @Binding var teamBoxSelection: Int

    public var body: some View {
        if let viewModel = viewModel {
            VStack {
                // boxscore content
                if interfaceSize.portrait {
                    ScrollView(.horizontal, showsIndicators: false) {
                        boxscore(for: viewModel)
                    }
                    .padding(.bottom, 16)
                } else {
                    boxscore(for: viewModel)
                }
                
                notes
            }
        }
        else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var notes: some View {
        if !selectedNotes.isEmpty {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Notes")
                    .font(.subheadline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(selectedNotes, id: \.self) {
                    Text($0)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.top)
        }
    }
    
    @ViewBuilder
    private func boxscore(for viewModel: BoxscoreGridViewModel) -> some View {
        Grid(verticalSpacing: 12) {
            
            BoxscoreRowView(viewModel: viewModel.type.header)
            
            Divider()
            
            ForEach(selectedBatters, id: \.id) { batter in
                BoxscoreRowView(viewModel: batter)
            }
            
            BoxscoreRowView(viewModel: selectedTotals)
                .padding(.top)
        }
    }
    
    private var selectedTeamAbbreviation: String {
        return teamBoxSelection == 0
        ? viewModel?.homeTeamAbbreviation ?? ""
        : viewModel?.awayTeamAbbreviation ?? ""
    }
    
    private var selectedBatters: [BoxscoreRowViewModel] {
        return teamBoxSelection == 0
        ? viewModel?.homeRows ?? []
        : viewModel?.awayRows ?? []
    }
    
    private var selectedTotals: BoxscoreRowViewModel {
        return teamBoxSelection == 0
        ? viewModel?.homeTotalsRow ?? BoxscoreRowViewModel(title: "-", subtitle: "-", item0: "-", item1: "-", item2: "-", item3: "-", item4: "-", item5: "-", item6: "-", item7: "-")
        : viewModel?.awayTotalsRow ?? BoxscoreRowViewModel(title: "-", subtitle: "-", item0: "-", item1: "-", item2: "-", item3: "-", item4: "-", item5: "-", item6: "-", item7: "-")
    }
    
    private var selectedNotes: [String] {
        return teamBoxSelection == 0
        ? viewModel?.homeNotes ?? []
        : viewModel?.awayNotes ?? []
    }
}
