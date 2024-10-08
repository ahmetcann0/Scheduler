// ContentView.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 2.08.2024.

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var toDoListItemViewModel: ToDoListItemViewModel 

    var body: some View {
        if appState.isUserLoggedIn {
            HomeView()
                .environmentObject(toDoListItemViewModel)
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState.shared)
    }
}
