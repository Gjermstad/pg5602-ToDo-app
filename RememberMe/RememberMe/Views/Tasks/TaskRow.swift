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
                if(task.subTitle != "") {
                    Text(task.subTitle)
                }
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
