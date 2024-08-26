//
//  ToDoListItemView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import SwiftUI

struct ToDoListItemView: View {
    @EnvironmentObject var viewModel: ToDoListItemViewModel
    let item: ToDoListItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                Text(formatDate(item.dueDate))
                    .font(.subheadline)
            }

            Spacer()

            Button {
                viewModel.toggleIsDone(for: item) { result in
                    switch result {
                    case .success(let updatedItem):
                        // Burada, başarılı güncellemeden sonra yapılacak işlemler
                        print("Item updated: \(updatedItem)")
                    case .failure(let error):
                        print("Error updating item: \(error)")
                    }
                }
            } label: {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
            }
        }
        .padding()
    }

    private func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateStyle = .medium
        displayFormatter.timeStyle = .short
        return displayFormatter.string(from: date)
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: ToDoListItem(
            id: 123,
            title: "Sample Task",
            dueDate: "2024-08-09T15:00:00Z",
            createdDate: "2024-08-08T12:00:00Z",
            userId: 123, isDone: false
        ))
        .environmentObject(ToDoListItemViewModel())
    }
}
