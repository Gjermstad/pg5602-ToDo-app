//
//  TaskEdit.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 05/10/2025.
//

import SwiftUI
import SwiftData

struct TaskEdit: View
{
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    var task: TaskModel
    
    @State private var title: String
    @State private var priority: Bool
    
    init(task: TaskModel)
    {
        self.task = task
        _title = State(initialValue: task.title)
        _priority = State(initialValue: task.priority)
    }
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section("Tittel og undertittel") {
                    TextField("Tittel", text: $title).bold()
                }
                
                Toggle("Prioritert", systemImage: "light.beacon.max.fill", isOn: $priority)
            }
            .navigationTitle("Rediger oppgave")
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt")
                    {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Lagre")
                    {
                        task.title = title
                        task.priority = priority
                        
                        task.updatedAt = .now
                        
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    TaskEdit(task: exampleTask1)
}
