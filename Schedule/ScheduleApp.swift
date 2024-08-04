//
//  ScheduleApp.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI

@main
struct ScheduleApp: App {
    @State private var isUserLoggedIn = false
    @State private var userToken = ""

    var body: some Scene {
        WindowGroup {
            ContentView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
        }
    }
}
