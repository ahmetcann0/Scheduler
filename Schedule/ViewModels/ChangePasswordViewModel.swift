//
//  ChangePasswordViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 8.09.2024.
//

import Foundation

class ChangePasswordViewModel: ObservableObject {
    @Published var oldPassword: String = ""
    @Published var newPassword: String = ""
    @Published var showingAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""

    func changePassword(userId: Int64?, token: String) {
        guard let userId = userId else {
            DispatchQueue.main.async {
                self.alertTitle = "Error"
                self.alertMessage = "Invalid user ID"
                self.showingAlert = true
            }
            return
        }
        
        // URL'ye userId'yi ekleyin
        let url = URL(string: "http://localhost:8080/users/change-password/\(userId)")!

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String: String] = [
            "oldPassword": oldPassword,
            "newPassword": newPassword
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Change password error: \(error)")
                DispatchQueue.main.async {
                    self?.alertTitle = "Error"
                    self?.alertMessage = "Failed to change password"
                    self?.showingAlert = true
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self?.alertTitle = "Error"
                    self?.alertMessage = "Failed to change password"
                    self?.showingAlert = true
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.alertTitle = "Success"
                self?.alertMessage = "Password changed successfully"
                self?.showingAlert = true
                self?.oldPassword = ""
                self?.newPassword = ""
            }
        }.resume()
    }
}
