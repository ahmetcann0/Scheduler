//
//  ToDoListViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    //@Published var tasks: [Task] = []

    func loadTasks(for userId: String) {
        // Burada userId'yi kullanarak görevleri yükleyin
        print("Loading tasks for user ID: \(userId)")
        // Örnek: UserService.shared.getTasks(userId: userId) { ... }
    }
}
