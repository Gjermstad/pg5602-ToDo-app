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
    
    // Henter alle tilgjengelige kategorier fra databasen
    @Query(sort: \CategoryModel.title) var categories: [CategoryModel]
    
    @State private var title = ""
    @State private var selectedCategoryTitle: String = "default"
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
            let visibleCategories = categories.filter{!$0.archived}
            
            Form
            {
                Section()
                {
                    TextField("Tittel", text: $title)
                    
                    // Om det ikke er lagd egne kategorier vises ikke valget og "default" settes
                    if (categories.count > 1)
                    {
                        Picker("Velg kategori", selection: $selectedCategoryTitle)
                        {
                            ForEach(visibleCategories)
                            {
                                category in
                                if(category.title != "default")
                                {
                                    Text(category.title).tag(category.title)
                                }
                            }
                        }
                    }
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
                        let chosenCategory = categories.first{$0.title == selectedCategoryTitle}
                        let category = chosenCategory ?? {
                            let c = CategoryModel(title: "default")
                            context.insert(c)
                            return c
                        }()
                        
                        let newTask = TaskModel(title: title, category: category)
                        
                        newTask.title = title
                        newTask.category = category
                        
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
