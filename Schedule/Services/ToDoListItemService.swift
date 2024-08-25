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
            print("Invalid URL: \(baseURL)/\(userId)/todos")
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

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(.failure(.invalidResponse))
                return
            }

            print("HTTP Status Code: \(httpResponse.statusCode)")

            guard httpResponse.statusCode == 200 else {
                print("Error status code: \(httpResponse.statusCode)")
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(.unknown))
                return
            }

            // Print raw JSON data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received JSON: \(jsonString)")
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
