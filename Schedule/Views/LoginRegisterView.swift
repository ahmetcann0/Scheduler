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
                .font(.largeTitle)
                .padding(.top, 40)
            
            Image("scheduler_icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 300, height: 300)
                .padding(.top, -40)


            Picker(selection: $viewModel.isLoginMode, label: Text("Login Mode")) {
                Text("Login").tag(true)
                Text("Sign Up").tag(false)
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
                Text(viewModel.isLoginMode ? "Login" : "Sign Up")
                    .foregroundColor(.white)
                            .padding(.vertical, 15)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(10)

            }
            .padding(.all, 30)

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
