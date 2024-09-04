//
//  ToDoListItemView.swift
//  Schedule
//
//  Created by Ahmet Can Öztürk on 9.08.2024.
//

import SwiftUI

struct ToDoListItemView: View {
    @EnvironmentObject var viewModel: ToDoListItemViewModel
    @Binding var item: ToDoListItem

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
                        item = updatedItem
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

    // Tarih formatlama fonksiyonu
    private func formatDate(_ dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date = inputDateFormatter.date(from: dateString) else { return dateString }

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "dd/MM/yyyy, HH:mm"
        outputDateFormatter.timeZone = TimeZone.current

        return outputDateFormatter.string(from: date)
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .constant(ToDoListItem(
            id: 123,
            title: "Sample Task",
            dueDate: "2023-08-07T09:00:00Z",
            createdDate: "2023-08-07T09:00:00Z",
            userId: 123, isDone: false
        )))
        .environmentObject(ToDoListItemViewModel())
    }
}
