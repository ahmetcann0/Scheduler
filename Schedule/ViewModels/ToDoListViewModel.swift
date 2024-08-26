//
//  ToDoListViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import Foundation
import Combine

class ToDoListViewModel: ObservableObject {
    @Published var tasks: [ToDoListItem] = []
    @Published var showingNewItemView = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadTasks(for userId: String) {
        guard let userIdInt64 = Int64(userId) else {
            print("Invalid user ID")
            return
        }
        
        print("Calling fetchToDoListItems for userId: \(userIdInt64)")
        ToDoListItemService.shared.fetchToDoListItems(for: userIdInt64) { [weak self] result in
            switch result {
            case .success(let items):
                DispatchQueue.main.async {
                    self?.tasks = items
                    print("Fetched tasks: \(items)")
                }
            case .failure(let error):
                print("Error fetching tasks: \(error)")
            }
        }
    }

    
    func addTask(_ task: ToDoListItem) {
        tasks.append(task)
    }
    
    func deleteTask(_ task: ToDoListItem) {
        // Kullanıcı ID'si ve görev ID'si doğrudan kullanılır
        let userIdInt64 = Int64(task.userId) // Int64 dönüşüm işlemi
        let taskIdInt64 = Int64(task.id)     // Int64 dönüşüm işlemi

        // ToDoListItemService ile silme işlemi yapılır
        ToDoListItemService.shared.deleteToDoListItem(withId: taskIdInt64, userId: userIdInt64) { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    // Görev başarıyla silindiğinde listeden çıkarılır
                    self?.tasks.removeAll { $0.id == task.id }
                }
            case .failure(let error):
                print("Error deleting task: \(error)")
            }
        }
    }

    
    
}
