//
//  ChangePasswordView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 8.09.2024.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = ChangePasswordViewModel()
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Change Password")) {
                    SecureField("Current Password", text: $viewModel.oldPassword)
                    SecureField("New Password", text: $viewModel.newPassword)
                    
                    Button(action: {
                        viewModel.changePassword(userId: appState.userId, token: appState.userToken)
                    }) {
                        Text("Change Password")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $viewModel.showingAlert) {
                        Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        .navigationTitle("Change Password")
        .padding()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView().environmentObject(AppState.shared)
    }
}
