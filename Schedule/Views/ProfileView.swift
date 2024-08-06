//
// ProfileView.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 6.08.2024.
//


import SwiftUI

struct ProfileView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var userToken: String
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
            .onChange(of: viewModel.isUserLoggedIn) {
                isUserLoggedIn = viewModel.isUserLoggedIn
            }
            .onChange(of: viewModel.userToken) {
                userToken = viewModel.userToken
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    @State static var isUserLoggedIn = true
    @State static var userToken = ""

    static var previews: some View {
        ProfileView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
    }
}
