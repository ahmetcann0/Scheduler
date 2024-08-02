//
//  ContentView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var isLoginMode = true
    @State private var showMessage = false
    @State private var message = ""

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Scheduler")
                    .font(.title)
                
                Image("scheduler_icon_loginpage1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.5)
                    .frame(height: geometry.size.height * 0.25)
                    .padding()

                Spacer()
                
                Picker(selection: $isLoginMode, label: Text("Login Mode")) {
                    Text("Login").tag(true)
                    Text("Signup").tag(false)
                }.pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5)
                    .padding(.horizontal, 20)

                Button(action: {
                    self.showMessage = false
                    if isLoginMode {
                        self.login()
                    } else {
                        self.register()
                    }
                }) {
                    Text(isLoginMode ? "Login" : "Signup")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()

                if showMessage {
                    Text(message)
                        .foregroundColor(isLoggedIn ? .green : .red)
                }
                
                Spacer()
            }
            .padding()
        }
    }

    func login() {
        guard let url = URL(string: "http://localhost:8080/api/users/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["username": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8), responseString.contains("id") {
                    DispatchQueue.main.async {
                        self.isLoggedIn = true
                        self.message = "Logged in successfully!"
                        self.showMessage = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoggedIn = false
                        self.message = "Login failed."
                        self.showMessage = true
                    }
                }
            }
        }.resume()
    }

    func register() {
        guard let url = URL(string: "http://localhost:8080/api/users/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: String] = ["username": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let responseString = String(data: data, encoding: .utf8), responseString.contains("id") {
                    DispatchQueue.main.async {
                        self.isLoggedIn = true
                        self.message = "Registered successfully!"
                        self.showMessage = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoggedIn = false
                        self.message = "Registration failed."
                        self.showMessage = true
                    }
                }
            }
        }.resume()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
