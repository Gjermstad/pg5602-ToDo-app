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
  @State private var startDate: Date
  @State private var dueDate: Date
  @State private var statusValue: Int8
  @State private var note: String
  @State private var priority: Bool
  
  init(task: TaskModel)
  {
    self.task = task
    _title = State(initialValue: task.title)
    _priority = State(initialValue: task.priority)
    _startDate = State(initialValue: task.startDate)
    _dueDate = State(initialValue: task.dueDate)
    _statusValue = State(initialValue: task.statusValue)
    _note = State(initialValue: task.notes)
  }
  
  var body: some View
  {
    Form
    {
      Section("Tittel")
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
            Text(status.title).tag(status.rawValue)
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
    .navigationTitle("Rediger oppgave")
    .navigationBarTitleDisplayMode(.inline)
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
          
          task.statusValue = statusValue
          
          task.startDate = startDate
          task.dueDate = dueDate
          
          task.notes = note
          
          task.priority = priority
          
          task.updatedAt = .now
          
          dismiss()
        }
      }
    }
  }
}

#Preview {
  TaskEdit(task: exampleTask1)
}
