//
//  ItemAdd.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import SwiftUI
import SwiftData

struct TaskAdd: View
{
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var startDate: Date = .now
    @State private var dueDate: Date = .now
    @State private var statusValue: Int8 = 0
    @State private var note = ""
    @State private var priority = false
    
    @AppStorage("darkmode") private var darkMode: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section()
                {
                    TextField("Tittel", text: $title)
                }
                
                Section("Status")
                {
                    Picker("Status", selection: $statusValue)
                    {
                        ForEach(Status.allCases)
                        {
                            status in
                            Text(status.title).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section()
                {
                    DatePicker("Start oppgaven", selection: $startDate)
                    DatePicker("Deadline", selection: $dueDate)
                }
                
                Section("Notater om oppgaven")
                {
                    TextEditor(text: $note)
                        .frame(minHeight: 80)
                }
                
                Section()
                {
                    Toggle("Prioritert", systemImage: "light.beacon.max.fill", isOn: $priority)
                }
            }
            .navigationTitle("Ny oppgave")
            .toolbar {
                ToolbarItem(placement: .cancellationAction)
                {
                    Button("Avbryt") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction)
                {
                    Button("Lagre") {
                        
                      let newTask = TaskModel(title: title)
                        
                        newTask.title = title
                        
                        newTask.statusValue = statusValue
                        
                        newTask.startDate = startDate
                        newTask.dueDate = dueDate
                        
                        newTask.notes = note
                        
                        newTask.priority = priority
                        
                        context.insert(newTask)
                        
                        dismiss()
                    }
                    .disabled(title == "")
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    TaskAdd()
}
