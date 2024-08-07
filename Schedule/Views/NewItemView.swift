//
//  NewItemView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewModel()
    
    var body: some View {
        VStack{
            Text("New Task")
                .font(.title)
                .bold()
            Form{
                TextField("Title", text: $viewModel.title)
                
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button(action: viewModel.save) {
                    Text("Save")
                }
            }
        }
    }
    
    struct NewItemView_Previews: PreviewProvider {
        static var previews: some View {
            NewItemView()
        }
    }
}
