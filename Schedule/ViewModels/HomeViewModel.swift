//
//  HomeViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var user: User?
    @Published var isUserLoggedIn: Bool
    @Published var userToken: String
    @Published var userId: Int = 0

    private var cancellables = Set<AnyCancellable>()

    init(isUserLoggedIn: Bool, userToken: String) {
        self.isUserLoggedIn = isUserLoggedIn
        self.userToken = userToken
        if isUserLoggedIn, !userToken.isEmpty {
            getUserInfo()
            if let savedUserId = UserDefaults.standard.value(forKey: "userId") as? Int {
                self.userId = savedUserId
            }
        }
    }

    func getUserInfo() {
        UserService.shared.getUserInfo(token: userToken) { [weak self] result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self?.user = user
                }
            case .failure(let error):
                print("Failed to get user info: \(error.localizedDescription)")
            }
        }
    }

    func logout() {
        UserService.shared.logout(token: userToken) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.isUserLoggedIn = false
                    self?.userToken = ""
                    self?.userId = 0
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "userId")
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
        }
    }
}
