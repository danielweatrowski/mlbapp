//
//  ScoresListView.swift
//  mlbapp
//
//  Created by Daniel Weatrowski on 5/22/23.
//

import SwiftUI
import Common
import Views
struct ScoresListView: View {
    
    @EnvironmentObject var sceneProvider: SceneProvider
    @StateObject var interactor: ScoresListInteractor
    @StateObject private var viewModel: ScoresList.ViewModel
    
    var body: some View {
        ZStack {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded:
                    ScrollView {
                        gameList
                            .padding(.bottom, 48)
                    }
                case .error:
                    EmptyView()
                }
            }
            .groupedBackground()
            VStack(alignment: .trailing) {
                Spacer()
                
                ScoresListDatePickerView(selectedDate: $viewModel.selectedDate, filterType: viewModel.filterType, didTapDate: {
                    viewModel.showCalendarSheet = true
                }, didTapNextDate: {
                    viewModel.selectedDate = interactor.getNextDay(from: viewModel.selectedDate)
                }, didTapPreviousDate: {
                    viewModel.selectedDate = interactor.getPreviousDay(from: viewModel.selectedDate)
                })
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
                Section {
                    Picker(selection: $viewModel.filterType, label: Text("Filter Games")) {
                        ForEach(ScoresList.FilterType.allCases) { option in
                            Text(String(describing: option))
                        }
                    }
                }
                Section {
                    Picker(selection: $viewModel.listType, label: Text("List Type")) {
                        ForEach(ScoresList.ListType.allCases) { option in
                            Text(String(describing: option))
                        }
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
        LazyVGrid(columns: viewModel.selectedColumns, spacing: 16) {
            ForEach(viewModel.filteredListItems, id: \.id) { item in
                
                NavigationLink(value: AppScene.gameDetail(gameID: item.gameID)) {
                    ScoresListGridItemView(viewModel: item, isCompact: viewModel.listType == .grid)
                        .background()
                        .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal)
        
    }
}

extension ScoresListView {
    static func configure<S: GameStoreProtocol>(gameStore: S) -> ScoresListView {
        let viewModel = ScoresList.ViewModel()
        let presenter = ScoresListPresenter(viewModel: viewModel)
        let interactor = ScoresListInteractor(presenter: presenter)
        
        return ScoresListView(interactor: interactor,
                              viewModel: viewModel)
    }
}
