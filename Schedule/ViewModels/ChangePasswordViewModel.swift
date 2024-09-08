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

    private let baseURL = "http://localhost:8080/users/change-password"
    
    func changePassword(userId: Int64?, token: String, completion: @escaping () -> Void) {
        guard let userId = userId else {
            showAlert(title: "Error", message: "Invalid user ID")
            return
        }
        
        guard let url = URL(string: "\(baseURL)/\(userId)") else {
            showAlert(title: "Error", message: "Invalid URL")
            return
        }
        
        var request = createRequest(url: url, token: token)
        
        let body: [String: String] = [
            "oldPassword": oldPassword,
            "newPassword": newPassword
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            showAlert(title: "Error", message: "Failed to encode request body")
            return
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Change password error: \(error)")
                self?.showAlert(title: "Error", message: "Failed to change password")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self?.showAlert(title: "Error", message: "Failed to change password")
                return
            }
            
            DispatchQueue.main.async {
                self?.showAlert(title: "Success", message: "Password changed successfully")
                self?.oldPassword = ""
                self?.newPassword = ""
                completion()
            }
        }.resume()
    }
    
    private func createRequest(url: URL, token: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    private func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            self.alertTitle = title
            self.alertMessage = message
            self.showingAlert = true
        }
    }
}
