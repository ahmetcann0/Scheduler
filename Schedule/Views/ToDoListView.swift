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
                // Görevler burada gösterilecek
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
                let userIdString = String(userId) // Int64'ü String'e dönüştür
                viewModel.loadTasks(for: userIdString)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(AppState.shared)
    }
}
