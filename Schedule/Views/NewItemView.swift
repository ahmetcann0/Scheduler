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
    @EnvironmentObject var appState: AppState

    init(newItemPresented: Binding<Bool>, appState: AppState) {
        _viewModel = StateObject(wrappedValue: NewItemViewModel(appState: appState))
        _newItemPresented = newItemPresented
    }
    
    var body: some View {
        VStack {
            Text("New Task")
                .font(.title)
                .bold()
                .padding(.top, 40)
            
            Form {
                Section {
                    TextField("Title", text: $viewModel.title
                    )
                        .padding()
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Section {
                    DatePicker("Due Date", selection: $viewModel.dueDate)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(.purple)
                }

                Button(action: {
                    if viewModel.canSave {
                        viewModel.save {
                            if let userId = appState.userId {
                                listViewModel.loadTasks(for: (userId))
                            }
                            newItemPresented = false
                        }
                    } else {
                        viewModel.showAlert = true
                    }
                }) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.purple)
                        .cornerRadius(10)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields"), dismissButton: .default(Text("OK")))
                }
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(0.8), Color.purple]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct NewItemView_Previews: PreviewProvider {
    @State static var newItemPresented = true
    static var appState = AppState.shared
    
    static var previews: some View {
        NewItemView(newItemPresented: $newItemPresented, appState: appState)
            .environmentObject(ToDoListViewModel())
            .environmentObject(appState)
    }
}
