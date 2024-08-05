//
//  HomeView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 2.08.2024.
//
import SwiftUI

struct HomeView: View {
    @Binding var isUserLoggedIn: Bool
    @Binding var userToken: String
    
    var body: some View {
        VStack {
            Text("Welcome to the Homepage!")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                logout()
            }) {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
            }
        }
    }
    
    func logout() {
        guard let token = UserDefaults.standard.string(forKey: "userToken") else {
            print("No token found")
            return
        }
        
        UserService.shared.logout(token: token) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.isUserLoggedIn = false
                    self.userToken = ""
                    UserDefaults.standard.removeObject(forKey: "userToken")
                }
            case .failure(let error):
                print("Logout failed: \(error.localizedDescription)")
            }
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
