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
    @State private var selectedCategoryTitle: String = "Default"
    
    @AppStorage("darkmode") private var darkMode: Bool = false
    
    var body: some View
    {
        NavigationStack
        {
            let visibleCategories = categories.filter{!$0.archived}
            
            Form
            {
                Section
                {
                    TextField("Tittel", text: $title)
                }
                
                Picker("Velg kategori", selection: $selectedCategoryTitle)
                {
                    Text("Ingen kategori").tag("default")
                    ForEach(visibleCategories)
                    {
                        category in
                        Text(category.title).tag(category.title)
                    }
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
                        
                        let task = TaskModel(title: title, category: category)
                        
                        task.title = title
                        task.category = category
                        
                        context.insert(task)
                        
                        dismiss()
                    }
                }
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

#Preview {
    TaskAdd()
}
