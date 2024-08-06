//
//  HomeView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//
// HomeView.swift
// Schedule
//
// Created by Ahmet Can Öztürk on 2.08.2024.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(isUserLoggedIn: Binding<Bool>, userToken: Binding<String>) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(isUserLoggedIn: isUserLoggedIn.wrappedValue, userToken: userToken.wrappedValue))
        _isUserLoggedIn = isUserLoggedIn
        _userToken = userToken
    }

    @Binding var isUserLoggedIn: Bool
    @Binding var userToken: String

    var body: some View {
        TabView {
            ToDoListView().tabItem {
                Label("Home", systemImage: "house")
            }
            ProfileView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken).tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
        .onChange(of: viewModel.isUserLoggedIn) {
            isUserLoggedIn = viewModel.isUserLoggedIn
        }
        .onChange(of: viewModel.userToken) {
            userToken = viewModel.userToken
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var isUserLoggedIn = true
    @State static var userToken = ""

    static var previews: some View {
        HomeView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
    }
}
