//
//  ToDoListItem.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import Foundation

struct ToDoListItem: Codable, Identifiable {
    let id: Int
    let title: String
    let dueDate: String
    let createdDate: String
    let userId: Int
    let isDone: Bool  

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case dueDate = "dueDate"
        case createdDate = "createdDate"
        case userId = "userId"
        case isDone = "done"
    }
}
