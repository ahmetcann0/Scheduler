//
//  ScheduleApp.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct ScheduleApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

  @StateObject private var appState = AppState.shared
  @StateObject private var toDoListItemViewModel = ToDoListItemViewModel()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appState)
        .environmentObject(toDoListItemViewModel)
    }
  }
}
