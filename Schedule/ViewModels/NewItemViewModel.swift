//
//  NewItemViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import Foundation
import Combine

class NewItemViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    @Published var appState: AppState
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func save(completion: @escaping () -> Void) {
        guard canSave else {
            return
        }
        
        let createdDate = Date()
        
        guard let userId = appState.userId else {
            print("User ID is required")
            return
        }
        
        let dateFormatter = ISO8601DateFormatter()
        let dueDateString = dateFormatter.string(from: dueDate)
        let createdDateString = dateFormatter.string(from: createdDate)

        let newItem = ToDoListItem(
            id: 0, // Backend tarafından ayarlanacak
            title: title,
            dueDate: dueDateString,
            createdDate: createdDateString,
            userId: Int(userId), isDone: false
        )

        guard let url = URL(string: "http://192.168.1.22:8080/users/\(userId)/todos") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(newItem)
            request.httpBody = jsonData
        } catch {
            print("Failed to encode item: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to send item: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                return
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }


    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        return true
    }
}
