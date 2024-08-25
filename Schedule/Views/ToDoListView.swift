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
                List(viewModel.tasks) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button("Sil") {
                                // Silme işlemi
                            }
                            .background(Color.red)
                        }
                }
                .listStyle(PlainListStyle())
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
            }
        }
        .onAppear {
            if let userId = appState.userId {
                print("Fetching tasks for userId: \(userId)") // Debug: Kullanıcı ID'si yazdırma
                viewModel.loadTasks(for: String(userId))
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(AppState.shared)
    }
}
