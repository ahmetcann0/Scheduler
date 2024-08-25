//
//  ToDoListItemService.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import Foundation

class ToDoListItemService {
    static let shared = ToDoListItemService()
    private let baseURL = "http://localhost:8080"

    private init() { }

    func fetchToDoListItems(for userId: Int64, completion: @escaping (Result<[ToDoListItem], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users/\(userId)/todos") else {
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

    func deleteToDoListItem(withId id: Int64, userId: Int64, completion: @escaping (Result<Void, NetworkError>) -> Void) {
        let urlString = "\(baseURL)/users/\(userId)/todos/\(id)"
        guard let url = URL(string: urlString) else {
            print("Geçersiz URL")
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 204:
                    completion(.success(()))
                case 404:
                    print("Öğe bulunamadı")
                    completion(.failure(.invalidResponse))
                default:
                    print("Beklenmeyen yanıt: \(httpResponse.statusCode)")
                    completion(.failure(.unknown))
                }
            } else {
                print("Geçersiz yanıt")
                completion(.failure(.unknown))
            }
        }.resume()
    }

}
