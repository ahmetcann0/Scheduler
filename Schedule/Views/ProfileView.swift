//
//  ProfileView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = ProfileViewModel()
    
    init (){
    }
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
