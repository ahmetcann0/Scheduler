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

    var body: some View {
        VStack {
            Text("Scheduler")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))

            Button(action: {
                // Login action
                self.login()
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            if isLoggedIn {
                Text("Logged in successfully!")
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    func login() {
        // Authentication logic here
        if email == "test@example.com" && password == "password" {
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
