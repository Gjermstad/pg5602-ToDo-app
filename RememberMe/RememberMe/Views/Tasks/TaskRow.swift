//
//  TaskRow.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 05/10/2025.
//

import SwiftUI

struct TaskRow: View {
    var task: TaskModel
  
  var taskStatus: some View {
    switch task.statusValue
    {
    case 0:
      return Text("Status: " + task.status.title).foregroundStyle(.red)
    case 1:
      return Text("Status: " + task.status.title).foregroundStyle(.yellow)
    case 2:
      return Text("Status: " + task.status.title).foregroundStyle(.brown)
    case 3:
      return Text("Status: " + task.status.title).foregroundStyle(.green)
    default:
      return Text("")
    }
  
  }
    
    var body: some View
    {
        HStack
        {
            VStack(alignment: .leading)
            {
                Text(task.title).bold().font(.title2)
                Text("Frist: " + task.dueDate.formatted(.dateTime
                    .day().month().year()
                    .hour().minute()
                    .locale(Locale(identifier: "nb_NO"))))
                taskStatus
            }
            
            Spacer()
            
            VStack(alignment: .trailing)
            {
                if(task.priority) {
                    Text("❗️").font(.title)
                }
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true)
      {
        // Sveip fra høyre → merk task som fullført
        Button
        {
          task.archived.toggle()
          task.status = .taskFinished
          task.updatedAt = .now
        }
      label:
        {
          Image(systemName: "checkmark.circle").tint(.green)
        }
      }
    }
}

#Preview {
    TaskRow(task: TaskModel(
      title: "Rydd rommet",
      priority: true,
    )).padding(30)
}
