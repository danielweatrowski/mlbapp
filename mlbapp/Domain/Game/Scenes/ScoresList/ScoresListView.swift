//
//  ScoresListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import SwiftUI

struct ScoresListView: View {
    
    @EnvironmentObject var router: Router
    @StateObject var interactor: ScoresListInteractor
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
                    viewModel.selectedDate = interactor.getNextDay(from: viewModel.selectedDate)
                }, didTapPreviousDate: {
                    viewModel.selectedDate = interactor.getPreviousDay(from: viewModel.selectedDate)
                })
                .padding(.bottom, 4)
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
        .toolbar {
            Menu {
                Picker(selection: $viewModel.filterType, label: Text("Filter Games")) {
                    ForEach(ScoresList.FilterType.allCases) { option in
                         Text(String(describing: option))
                     }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .onReceive(viewModel.$filterType) { newFilter in
                print(newFilter)
            }
        }
        .background(
            Color(uiColor: .systemGroupedBackground)
        )
        .navigationTitle(viewModel.navigationTitle)
        .withSceneError($viewModel.sceneError)
        .onAppear {
            interactor.loadScores(for: viewModel.selectedDate)
        }
        .onReceive(viewModel.$selectedDate) { newDate in
            viewModel.state = .loading
            interactor.loadScores(for: newDate)
        }

    }
    
    @ViewBuilder
    var gameList: some View {
        if let rows = viewModel.filteredRows {
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
