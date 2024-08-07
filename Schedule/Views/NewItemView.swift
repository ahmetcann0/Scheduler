//
//  NewItemView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import SwiftUI

struct NewItemView: View {
    
    @StateObject var viewModel = NewItemViewModel()
    @Binding var newItemPresented: Bool
    
    var body: some View {
        VStack {
            Text("New Task")
                .font(.title)
                .bold()
                .padding(.top, 100)
            Form {
                TextField("Title", text: $viewModel.title)
                
                DatePicker("Due Date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                Button(action: {
                    if viewModel.canSave {
                        viewModel.save()
                        newItemPresented = false
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields"), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct NewItemView_Previews: PreviewProvider {
    @State static var newItemPresented = true

    static var previews: some View {
        NewItemView(newItemPresented: $newItemPresented)
    }
}
