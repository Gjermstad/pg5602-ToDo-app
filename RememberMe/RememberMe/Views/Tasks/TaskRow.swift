//
//  TaskRow.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 05/10/2025.
//

import SwiftUI

struct TaskRow: View {
    var task: TaskModel
    
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
                Text("Status: " + task.status.title)
            }
            
            Spacer()
            
            VStack(alignment: .trailing)
            {
                if(task.priority) {
                    Text("❗️").font(.title)
                }
            }
        }
    }
}

#Preview {
    TaskRow(task: exampleTask1).padding(30)
}
