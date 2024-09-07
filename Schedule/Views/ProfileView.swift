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
                HStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.purple)
                    
                    VStack(alignment: .leading) {
                        Text("Ahmet Can Öztürk")
                            .font(.headline)
                        Text("ahmetcan@example.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()

                // Task Statistics
                HStack {
                    VStack {
                        Text("10")
                            .font(.title)
                            .bold()
                        Text("Completed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack {
                        Text("5")
                            .font(.title)
                            .bold()
                        Text("Incomplete")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()

                // Settings
                Section(header: Text("Settings").font(.headline)) {
                    Toggle("Dark Mode", isOn: $viewModel.isDarkMode)
                        .padding()

                    NavigationLink(destination: Text("Notification Settings")) {
                        Text("Notification Settings")
                    }
                    .padding(.vertical, 10)

                    NavigationLink(destination: Text("Change Password")) {
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
