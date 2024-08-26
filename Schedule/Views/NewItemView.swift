//
//  NewItemView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import SwiftUI

struct NewItemView: View {
    @StateObject var viewModel: NewItemViewModel
    @Binding var newItemPresented: Bool
    @EnvironmentObject var listViewModel: ToDoListViewModel
    @EnvironmentObject var appState: AppState // AppState'i EnvironmentObject olarak ekleyin

    init(newItemPresented: Binding<Bool>, appState: AppState) {
        _viewModel = StateObject(wrappedValue: NewItemViewModel(appState: appState))
        _newItemPresented = newItemPresented
    }
    
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
                        viewModel.save {
                            // `ToDoListViewModel`'i güncellemek için loadTasks çağırabilirsiniz
                            if let userId = appState.userId {
                                listViewModel.loadTasks(for: String(userId))
                            }
                            newItemPresented = false
                        }
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
    static var appState = AppState.shared
    
    static var previews: some View {
        NewItemView(newItemPresented: $newItemPresented, appState: appState)
            .environmentObject(ToDoListViewModel()) // Preview için environmentObject ekleyin
            .environmentObject(appState) // Preview için environmentObject ekleyin
    }
}
