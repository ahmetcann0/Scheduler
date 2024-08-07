//
// ProfileViewModel.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private var appState = AppState.shared

    func logout() {
        UserService.shared.logout(token: appState.userToken) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.appState.isUserLoggedIn = false
                    self?.appState.userToken = ""
                    self?.appState.userId = ""
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "userId")
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
}
