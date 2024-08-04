//
//  User.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//

import Foundation

struct User: Codable {
    let id: Int
    let email: String
    let token: String?
}
