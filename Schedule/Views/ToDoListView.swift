//
//  ToDoListView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
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
                    // Sheet Açma Kodları
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            viewModel.loadTasks(for: appState.userId)
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView().environmentObject(AppState.shared)
    }
}
