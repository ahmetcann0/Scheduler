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
    @Environment(\.presentationMode) var presentationMode
    
    private let primaryColor = Color.purple
    private let secondaryColor = Color.white
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Change Password")
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)) {
                    SecureField("Current Password", text: $viewModel.oldPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 4)
                    SecureField("New Password", text: $viewModel.newPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.vertical, 4)
                    
                    Button(action: {
                        viewModel.changePassword(userId: appState.userId, token: appState.userToken) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }) {
                        Text("Change Password")
                            .foregroundColor(secondaryColor)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(primaryColor)
                            .cornerRadius(10)
                    }
                    .alert(isPresented: $viewModel.showingAlert) {
                        Alert(title: Text(viewModel.alertTitle), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .background(primaryColor.opacity(0.1)) // Form background color
            .scrollContentBackground(.hidden)
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
