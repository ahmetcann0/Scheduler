//
// ProfileViewModel.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var isUserLoggedIn: Bool = true
    @Published var userToken: String = ""

    func logout() {
        UserService.shared.logout(token: userToken) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.isUserLoggedIn = false
                    self?.userToken = ""
                    UserDefaults.standard.removeObject(forKey: "userToken")
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
}
