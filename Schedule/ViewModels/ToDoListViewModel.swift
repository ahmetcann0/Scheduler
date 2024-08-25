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
}
