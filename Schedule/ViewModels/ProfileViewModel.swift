//
// ProfileViewModel.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation
import SwiftUI


class ProfileViewModel: ObservableObject {
    private var appState = AppState.shared
    @Published var isDarkMode: Bool = false
    @Published var user: User?

    init() {
        isDarkMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark
        fetchUserInfo()
    }

    func fetchUserInfo() {
        guard let userId64 = appState.userId, userId64 != 0 else {
            print("User ID is empty or zero.")
            return
        }
        
        let userId = Int(userId64)
        print("Fetching user info for userId: \(userId)")

        UserService.shared.getUserInfoById(userId: userId) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                }
            case .failure(let error):
                print("Failed to fetch user info. User ID: \(userId), Error: \(error.localizedDescription)")
            }
        }
    }


    func logout() {
        UserService.shared.logout(token: appState.userToken) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.appState.isUserLoggedIn = false
                    self?.appState.userToken = ""
                    self?.appState.userId = 0
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "userId")
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
}
