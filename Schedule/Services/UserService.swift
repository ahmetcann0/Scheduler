//
//  UserService.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//
import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
    case invalidResponse
}

class UserService {
    static let shared = UserService()
    private let baseURL = "http://localhost:8080/users"

    private init() { }

    func login(email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Login error: \(error)")
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

            if let responseString = String(data: data, encoding: .utf8) {
                print("Login Response Data: \(responseString)")
            }

            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(user))
        }.resume()
    }

    func register(email: String, password: String, completion: @escaping (Result<User, NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Register error: \(error)")
                completion(.failure(.requestFailed))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.unknown))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Register Response Data: \(responseString)")
            }

            guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                completion(.failure(.unknown))
                return
            }

            completion(.success(user))
        }.resume()
    }
}
