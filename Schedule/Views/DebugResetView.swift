//
//  DebugResetView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 5.08.2024.
//

import SwiftUI

struct DebugResetView: View {
    var body: some View {
        VStack {
            Text("Resetting app...")
                .font(.largeTitle)
                .padding()

            Button(action: {
                UserDefaults.standard.removeObject(forKey: "userToken")
                UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
                // Restart the app or redirect to login page
            }) {
                Text("Reset App")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            // Optionally reset here automatically
            UserDefaults.standard.removeObject(forKey: "userToken")
            UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        }
    }
}
