//
//  ScoresListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import SwiftUI

struct ScoresListView: View {
    
    @EnvironmentObject var router: Router
    var interactor: ScoresListBusinessLogic?
    @StateObject private var viewModel: ScoresList.ViewModel
    
    var columns = [
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded:
                    // TODO: Try using ListGameView.configure(_:) here
                    ScrollView {
                        gameList
                    }
                case .error:
                    EmptyView()
                }
            }
            VStack(alignment: .trailing) {
                Spacer()
                
                ScoresListDatePickerView(selectedDate: $viewModel.selectedDate, didTapDate: {
                    viewModel.showCalendarSheet = true
                }, didTapNextDate: {
                    viewModel.selectedDate = interactor!.getNextDay(from: viewModel.selectedDate)
                }, didTapPreviousDate: {
                    viewModel.selectedDate = interactor!.getPreviousDay(from: viewModel.selectedDate)
                })
                    .padding([.bottom])
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .sheet(isPresented: $viewModel.showCalendarSheet) {
            DatePicker(selection: $viewModel.selectedDate, displayedComponents: .date) {}
                .labelsHidden()
                .datePickerStyle(.graphical)
                .padding([.horizontal])
                .presentationDetents([.medium])
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )
        .navigationTitle(viewModel.navigationTitle)
        .onAppear {
            interactor?.loadScores(for: viewModel.selectedDate)
        }
        .onReceive(viewModel.$selectedDate) { newDate in
            viewModel.state = .loading
            interactor?.loadScores(for: newDate)
        }
    }
    
    @ViewBuilder
    var gameList: some View {
        if let rows = viewModel.rows {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(rows, id: \.id) { row in
                    
                    NavigationLink(value: RouterDestination.gameDetail(gameID: row.gameID)) {
                        ListGameRow(viewModel: row)
                            .background()
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding([
                    .bottom,
                    .leading,
                    .trailing
                ])
            }
        } else {
            EmptyView()
        }
    }
}

extension ScoresListView {
    static func configure() -> ScoresListView {
        let viewModel = ScoresList.ViewModel()
        let presenter = ScoresListPresenter(viewModel: viewModel)
        let interactor = ScoresListInteractor(presenter: presenter)
        
        return ScoresListView(interactor: interactor,
                              viewModel: viewModel)
    }
}
