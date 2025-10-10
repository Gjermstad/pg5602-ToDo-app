//
//  StartView.swift
//  RememberMe
//
//  Created by Kenneth André Bettum Gjermstad on 02/10/2025.
//

import SwiftUI
import SwiftData

struct TaskView: View
{
  enum SortKey: String, CaseIterable, Identifiable {
    case dueDate, priority, title
    var id: String { rawValue }
  }
  
  @Query(filter: #Predicate<TaskModel>{!$0.archived}) private var tasks: [TaskModel]
  
  @State private var sortKey: SortKey = .dueDate
  @State private var ascending: Bool = true
  
  // For sortering av oppgaver
  var visibleTasks: [TaskModel] {
    tasks.sorted
    { a, b in
      switch sortKey
      {
        case .dueDate:
          let left = a.dueDate
          let right = b.dueDate
          return ascending
          ? (left < right)
          : (left > right)
        case .priority:
          return ascending
          ? (a.priority && !b.priority)
          : (!a.priority && b.priority)
        case .title:
          return ascending
          ? a.title.localizedCompare(b.title) == .orderedAscending
          : a.title.localizedCompare(b.title) == .orderedDescending
      }
    }
  }
  
  var body: some View
  {
    NavigationStack
    {
      Group
      {
        if(tasks.isEmpty)
        {
          EmptyView()
        }
        else
        {
          MessageView(text: "Sveip til venstre for å fjerne en oppgave fra listen.")
          
          List
          {
            
            ForEach(visibleTasks)
            { task in
              NavigationLink
              {
                TaskEdit(task: task)
              }
            label:
              {
                TaskRow(task: task)
              }
              
            }
          }
          .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
              Menu {
                Picker("Sorter etter", selection: $sortKey) {
                  Text("Dato").tag(SortKey.dueDate)
                  Text("Prioritet").tag(SortKey.priority)
                  Text("Tittel").tag(SortKey.title)
                }
                Button(ascending ? "Stigende ↑" : "Synkende ↓") {
                  ascending.toggle()
                }
              } label: {
                Label("Sorter", systemImage: "arrow.up.arrow.down")
              }
            }
          }
        }
      }
      .navigationTitle("Oppgaver")
    }
  }
}

#Preview {
  TaskView().modelContainer(for: [TaskModel.self, CategoryModel.self])
}
