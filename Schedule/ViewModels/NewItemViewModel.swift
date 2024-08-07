//
//  NewItemViewModel.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 7.08.2024.
//

import Foundation

class NewItemViewModel: ObservableObject{
    
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    init(){}
    
    func save(){
        
        
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else{
            return false
        }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else{
            return false
        }
        return true
    }
    
    
    
}
