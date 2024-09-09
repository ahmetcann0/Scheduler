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
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .strikethrough(item.isDone, color: .black)
                
                Text(formatDate(item.dueDate))
                    .font(.system(size: 12))
                    .foregroundColor(item.isDone ? .black.opacity(0.8) : .black)
                    .strikethrough(item.isDone, color: .black)

            }

            Spacer()

            Button(action: {
                viewModel.toggleIsDone(for: item) { result in
                    switch result {
                    case .success(let updatedItem):
                        item = updatedItem
                        print("Item updated: \(updatedItem)")
                    case .failure(let error):
                        print("Error updating item: \(error)")
                    }
                }
            }) {
                Image(systemName: item.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isDone ? Color.white : Color.black)
                    .font(.system(size: 24))
                    .padding()
                    .background(item.isDone ? Color.black.opacity(0.3) : Color.purple.opacity(0.3))
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(
            backgroundView
        )
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 2, y: 2)
    }

    @ViewBuilder
    private var backgroundView: some View {
        if item.isDone {
            Color(UIColor.systemGray2)
        } else {
            LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.9), Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.3)
        }
    }

    private func formatDate(_ dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        inputDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        guard let date = inputDateFormatter.date(from: dateString) else { return dateString }

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d MMM yyyy 'at' HH:mm"
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
        .previewLayout(.sizeThatFits)
    }
}
