//
//  ToDoListItem.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: Int64
    let title: String
    let dueDate: String // veya Date türü kullanabilirsiniz
    let createdDate: String // veya Date türü kullanabilirsiniz
    var isDone: Bool
    let userId: Int64;
    

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}
