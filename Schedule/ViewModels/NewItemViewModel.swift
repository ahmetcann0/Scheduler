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
    
    init(){}
    
    func save(){
        
        
    }
    
}
