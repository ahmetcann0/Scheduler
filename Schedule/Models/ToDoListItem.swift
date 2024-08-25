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
    let isDone: Bool  // JSON'daki 'done' ile eşleşecek şekilde 'isDone' olarak adlandırılıyor

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case dueDate = "dueDate" // JSON'daki 'dueDate' ile eşleşiyor
        case createdDate = "createdDate" // JSON'daki 'createdDate' ile eşleşiyor
        case userId = "userId" // JSON'daki 'userId' ile eşleşiyor
        case isDone = "done" // JSON'daki 'done' ile eşleşiyor
    }
}
