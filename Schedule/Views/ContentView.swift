//
//  ContentView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//

import SwiftUI

struct ContentView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var userToken: String

    var body: some View {
        if isUserLoggedIn {
            HomeView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var isUserLoggedIn = false
    @State static var userToken = ""

    static var previews: some View {
        ContentView(isUserLoggedIn: $isUserLoggedIn, userToken: $userToken)
    }
}
