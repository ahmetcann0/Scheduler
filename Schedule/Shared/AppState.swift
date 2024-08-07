//
//  AppState.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import Foundation

class AppState: ObservableObject {
    @Published var isUserLoggedIn: Bool = false
    @Published var userToken: String = ""
    @Published var userId: String = ""
    @Published var user: User?

    static let shared = AppState()
}
