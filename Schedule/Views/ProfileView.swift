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
            VStack {
                Button(action: {
                    viewModel.logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(AppState.shared)
    }
}
