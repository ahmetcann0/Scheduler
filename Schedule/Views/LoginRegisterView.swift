//  LoginRegisterView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 27.07.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack {
            Text("Scheduler")
                .font(.title)
            
            Image("scheduler_icon_loginpage1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()

            Picker(selection: $viewModel.isLoginMode, label: Text("Login Mode")) {
                Text("Login").tag(true)
                Text("Signup").tag(false)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            TextField("Email", text: $viewModel.email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
                .padding(.horizontal, 10)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            Button(action: {
                viewModel.showMessage = false
                if viewModel.isLoginMode {
                    viewModel.login()
                } else {
                    viewModel.register()
                }
            }) {
                Text(viewModel.isLoginMode ? "Login" : "Signup")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()

            if viewModel.showMessage {
                Text(viewModel.message)
                    .foregroundColor(appState.isUserLoggedIn ? .green : .red)
            }

            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AppState.shared)
    }
}
