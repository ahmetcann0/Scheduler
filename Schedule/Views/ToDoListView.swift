//
//  ToDoListView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel = ToDoListViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            VStack {
                List {
                    // Tamamlanmamış görevler
                    Section(header: Text("Incomplete Tasks")) {
                        ForEach(viewModel.incompleteTasks.indices, id: \.self) { index in
                            ToDoListItemView(item: $viewModel.incompleteTasks[index])
                                .swipeActions {
                                    Button("Sil") {
                                        viewModel.deleteTask(viewModel.incompleteTasks[index])
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                    
                    // Tamamlanmış görevler
                    Section(header: Text("Completed Tasks")) {
                        ForEach(viewModel.completedTasks.indices, id: \.self) { index in
                            ToDoListItemView(item: $viewModel.completedTasks[index])
                                .swipeActions {
                                    Button("Sil") {
                                        viewModel.deleteTask(viewModel.completedTasks[index])
                                    }
                                    .tint(.red)
                                }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationTitle("Tasks")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView(newItemPresented: $viewModel.showingNewItemView, appState: appState)
                    .environmentObject(viewModel)
                    .environmentObject(appState)
            }
        }
        .onAppear {
            if let userId = appState.userId {
                print("Fetching tasks for userId: \(userId)")
                viewModel.loadTasks(for: userId)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(AppState.shared)
    }
}
