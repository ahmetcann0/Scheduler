//
//  ScheduleApp.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI

@main
struct ScheduleApp: App {
    @StateObject private var appState = AppState.shared
    @StateObject private var toDoListItemViewModel = ToDoListItemViewModel() // Burada model örneğini oluşturun

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(toDoListItemViewModel) // Modeli burada sağlayın
        }
    }
}
