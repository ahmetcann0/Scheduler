//
//  ToDoListItemViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import SwiftUI

class ToDoListItemViewModel: ObservableObject {
    @Published var items: [ToDoListItem] = []

    func toggleIsDone(for item: ToDoListItem, completion: @escaping (Result<ToDoListItem, NetworkError>) -> Void) {
        var updatedItem = item
        updatedItem.isDone.toggle()

        
        ToDoListItemService.shared.updateToDoListItem(updatedItem) { result in
            switch result {
            case .success(let newItem):
                DispatchQueue.main.async {
                    self.updateItemInList(newItem)
                    completion(.success(newItem))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private func updateItemInList(_ updatedItem: ToDoListItem) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
            items.sort { $0.isDone && !$1.isDone }
        }
    }
}
