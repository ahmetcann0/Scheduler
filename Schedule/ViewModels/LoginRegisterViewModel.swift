//
//  LoginRegisterViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoginMode = true
    @Published var showMessage = false
    @Published var message = ""

    private let appState = AppState.shared

    func login() {
        UserService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.appState.isUserLoggedIn = true
                    self.appState.userToken = user.token ?? ""
                    self.appState.userId = Int64(user.id)
                    UserDefaults.standard.set(self.appState.userToken, forKey: "userToken")
                    UserDefaults.standard.set(self.appState.userId, forKey: "userId")
                    self.message = "Logged in successfully! User ID: \(user.id)"
                    self.showMessage = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = "Login failed: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }

    func register() {
        UserService.shared.register(email: email, password: password) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.appState.isUserLoggedIn = true
                    self.appState.userToken = user.token ?? ""
                    self.appState.userId = Int64(user.id)
                    self.message = "Registered successfully! User ID: \(user.id)"
                    self.showMessage = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = "Registration failed: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }
}
