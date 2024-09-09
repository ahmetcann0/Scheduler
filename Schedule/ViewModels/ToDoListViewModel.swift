//
//  ToDoListViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import Combine
import Foundation

class ToDoListViewModel: ObservableObject {
    @Published var incompleteTasks: [ToDoListItem] = []
    @Published var completedTasks: [ToDoListItem] = []
    @Published var showingNewItemView = false

    private var cancellables = Set<AnyCancellable>()
    private let taskService = ToDoListItemService.shared // Güncellenmiş servis kullanımı

    func loadTasks(for userId: Int64) {
        taskService.fetchToDoListItems(for: userId) { result in
            switch result {
            case .success(let tasks):
                DispatchQueue.main.async {
                    self.updateTaskLists(with: tasks)
                }
            case .failure(let error):
                print("Error fetching tasks: \(error)")
            }
        }
    }

    func deleteTask(_ task: ToDoListItem) {
        taskService.deleteToDoListItem(withId: Int64(task.id), userId: Int64(task.userId)) { result in
            switch result {
            case .success:
                self.loadTasks(for: Int64(task.userId)) // Kullanıcı ID'sini güncel kullanın
            case .failure(let error):
                print("Error deleting task: \(error)")
            }
        }
    }

    func toggleTaskStatus(_ task: ToDoListItem) {
        var updatedTask = task
        updatedTask.isDone.toggle()
        
        taskService.updateToDoListItem(updatedTask) { result in
            switch result {
            case .success(let newItem):
                DispatchQueue.main.async {
                    self.updateTaskLists(with: self.incompleteTasks + self.completedTasks)
                }
            case .failure(let error):
                print("Error updating task: \(error)")
            }
        }
    }

    private func updateTaskLists(with tasks: [ToDoListItem]) {
        incompleteTasks = tasks.filter { !$0.isDone }
        completedTasks = tasks.filter { $0.isDone }
    }
}
