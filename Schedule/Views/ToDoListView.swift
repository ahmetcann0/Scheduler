//
//  ToDoListView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 6.08.2024.
//

import SwiftUI

struct ToDoListView: View {
    
    @StateObject var viewModel = ToDoListViewModel()
    
    init(){}
    
    var body: some View {
        
        NavigationView{
            VStack{
                
            }
            .navigationTitle("Tasks")
            .toolbar{
                Button{
                    // Sheet Açma Kodları
                }label: {
                    Image(systemName: "plus")
                }
            }
        }


    }
}

#Preview {
    ToDoListView()
}
