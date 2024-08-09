//
//  ToDoListItemService.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import Foundation

class ToDoListItemService {
    static let shared = ToDoListItemService()
    private let baseURL = "http://localhost:8080/users"

    private init() { }

    func fetchToDoListItems(for userId: Int64, completion: @escaping (Result<[ToDoListItem], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(userId)/todos") else {
            completion(.failure(.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Fetch To-Do items error: \(error)")
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            do {
                let items = try JSONDecoder().decode([ToDoListItem].self, from: data)
                completion(.success(items))
            } catch {
                print("Decoding To-Do items error: \(error)")
                completion(.failure(.unknown))
            }
        }.resume()
    }
}
