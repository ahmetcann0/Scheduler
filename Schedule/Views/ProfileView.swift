//
// ProfileView.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 6.08.2024.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // User Information
                              if let user = viewModel.user {
                                  HStack {
                                      Image(systemName: "person.circle.fill")
                                          .resizable()
                                          .frame(width: 80, height: 80)
                                          .foregroundColor(.purple)
                                      
                                      VStack(alignment: .leading) {
                                          Text(user.email)
                                              .font(.headline)
                                      }
                                  }
                                  .padding()
                              } else {
                                  // Loading state or fallback
                                  Text("Loading user information...")
                                      .foregroundColor(.gray)
                              }

             
                // Settings
                Section(header: Text("Settings").font(.headline)) {
                    Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                        .padding()

                    NavigationLink(destination: Text("Notification Settings")) {
                        Text("Notification Settings")
                    }
                    .padding(.vertical, 10)

                    NavigationLink(destination: ChangePasswordView().environmentObject(appState)) {
                        Text("Change Password")
                    }
                    .padding(.vertical, 10)

                }

                Spacer()

                Button(action: {
                    viewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            .padding()
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AppState.shared)
    }
}
