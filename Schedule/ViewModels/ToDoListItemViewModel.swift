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

        // İstemci tarafında güncellemeyi simüle ediyoruz
        // Gerçek güncelleme için backend'e PUT isteği gönderilmelidir.
        // Bu örnek kodda backend'e istekte bulunmayı simüle edelim:
        ToDoListItemService.shared.updateToDoListItem(updatedItem) { result in
            switch result {
            case .success(let newItem):
                DispatchQueue.main.async {
                    // Listeyi güncelleyelim ve tamamlanan görevleri en sona kaydıralım
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
            // Tamamlanan görevleri en sona kaydırmak için sıralama
            items.sort { $0.isDone && !$1.isDone }
        }
    }
}
