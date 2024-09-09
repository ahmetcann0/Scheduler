//
//  HomeView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var appState = AppState.shared

    var body: some View {
        TabView {
            ToDoListView()
                .tabItem {
                    Label("Home", systemImage: "house").foregroundColor(.black)
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle").foregroundColor(.black)
                }
        }.accentColor(.purple) 
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
