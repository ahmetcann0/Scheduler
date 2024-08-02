//
//  ContentView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isUserLoggedIn = false

    var body: some View {
        if isUserLoggedIn {
            HomeView()
        } else {
            LoginView(isUserLoggedIn: $isUserLoggedIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
