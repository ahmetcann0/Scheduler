//  LoginView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoginMode = true
    @State private var showMessage = false
    @State private var message = ""
    @Binding var isUserLoggedIn: Bool
    @Binding var userToken: String

    var body: some View {
        VStack {
            Text("Scheduler")
                .font(.title)
            
            Image("scheduler_icon_loginpage1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()

            
            Picker(selection: $isLoginMode, label: Text("Login Mode")) {
                Text("Login").tag(true)
                Text("Signup").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .autocapitalization(.none) // Büyük harfleri otomatik olarak düzelten özelliği kapatır
                .disableAutocorrection(true) // Otomatik düzeltmeyi kapatır

            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .autocapitalization(.none) // Büyük harfleri otomatik olarak düzelten özelliği kapatır
                .disableAutocorrection(true) // Otomatik düzeltmeyi kapatır

            Button(action: {
                self.showMessage = false
                if isLoginMode {
                    login()
                } else {
                    register()
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
                    .foregroundColor(isUserLoggedIn ? .green : .red)
            }
            
            Spacer()
        }
        .padding()
    }

    func login() {
        UserService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isUserLoggedIn = true
                    self.userToken = user.token ?? ""
                    UserDefaults.standard.set(self.userToken, forKey: "userToken")
                    self.message = "Logged in successfully! User ID: \(user.id)"
                    self.showMessage = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = "Login failed: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }

    func register() {
        UserService.shared.register(email: email, password: password) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.isUserLoggedIn = true
                    self.userToken = user.token ?? ""
                    self.message = "Registered successfully! User ID: \(user.id)"
                    self.showMessage = true
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = "Registration failed: \(error.localizedDescription)"
                    self.showMessage = true
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    @State static var isUserLoggedIn = false
    @State static var userToken = ""

    static var previews: some View {
        LoginView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
    }
}
